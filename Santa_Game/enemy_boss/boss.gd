'''
For 'boss' scene.
The scene works similarly to the script.

This script manages the behavior of the boss character and its bullet firing patterns in the game.

1. Boss Character Properties Setup:
	It sets attributes such as HP (Health Points), speed, bullet firing rate, and bullet firing patterns for the boss character.

2. Boss Character Movement and Attack Logic:
	The boss character's movement changes in random directions at regular intervals, and it does not fire bullets while moving.
	There is a timer that periodically triggers bullet firing, and it randomly selects one of the predefined firing patterns to execute.

3. Bullet Pattern Management:
	It includes patterns like firing bullets toward the player character (pattern_to_player) and firing bullets in a circular pattern (pattern_circle). The spiral pattern is commented out and inactive.

4. Player Position Retrieval:
	It retrieves the position of the player character to be used in bullet firing patterns.

5. Damage Handling:
	The boss character can take damage, reducing its HP. When damaged, it plays related animations. If HP falls below zero, it triggers the boss's death (die) and transitions to the next stage.

6. Direction Update:
	It updates the character's direction, flipping the sprite's orientation when necessary.
'''

extends CharacterBody2D

# Boss settings
@export var HP = 200
@export var speed = 200
var move_timer = Timer.new()
var is_firing = false
var fire_pause_timer = 0.0
@export var fire_pause_duration = 0.5

# For boss bullet settings
@export var bullet_scene = preload("res://enemy_boss/boss_bullet.tscn")	# boss bullet scene path
@export var fire_rate = 2.0
var fire_timer = Timer.new()
var patterns = ["pattern_to_player", "pattern_circle"] # "pattern_spiral"]

# Boss Animation
@onready var animation = $AnimatedSprite2D
var facing_right = false  # boss direction: is it facing right?


func _ready():
	# Move timer setup
	add_child(move_timer)
	move_timer.wait_time = 1  # change direction in n seconds
	move_timer.connect("timeout", Callable(self, "_on_move_timer_timeout"))
	move_timer.start()

	# Bullet firing timer setup
	add_child(fire_timer)
	fire_timer.wait_time = fire_rate
	fire_timer.connect("timeout", Callable(self, "_on_fire_timer_timeout"))
	fire_timer.start()

func _on_move_timer_timeout():
	var random_direction = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()
	velocity = random_direction * speed  # Update Speed
	update_direction(random_direction)
	animation.play("boss_walk")

func _physics_process(delta):
	$HealthBar.value = HP
	
	if is_firing:
		fire_pause_timer += delta
		if fire_pause_timer >= fire_pause_duration:
			# Restore boss movement after a certain time
			is_firing = false
			fire_pause_timer = 0.0
			velocity = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized() * speed
			animation.play("boss_idle")
	else:
		move_and_slide()

func _on_fire_timer_timeout():
	is_firing = true  # Stop boss when firing
	velocity = Vector2.ZERO
	var pattern = patterns[randi() % patterns.size()]
	call(pattern)
	animation.play("boss_attack")

# Bullet pattern management
# 1. Fire toward the player
# 2. Fire in a circular pattern
# for test: Fire in a spiral pattern (on hold, may be replaced with another pattern)
func pattern_to_player():
	var bullet_instance = bullet_scene.instantiate()
	get_parent().add_child(bullet_instance)  # # Add the bullet to the boss's parent node (should not be affected by boss movement)
	bullet_instance.global_position = global_position
	# Mod size of bullet
	bullet_instance.scale = Vector2(2, 2)  # 원래 크기의 k배
	# Mod speed for bullet
	bullet_instance.speed = 1200  # 속도 = n 으로 설정
	# Mod bullet damage
	bullet_instance.damage = 20
	# get Player position and set target direction
	var target_direction = (get_player_position() - bullet_instance.global_position).normalized()
	bullet_instance.set_direction(target_direction)
	# set animation direction
	update_direction(target_direction)

func pattern_circle():
	var bullet_count = 20
	var angle_step = 2 * PI / bullet_count
	
	for i in range(bullet_count):
		var bullet = bullet_scene.instantiate()
		get_parent().add_child(bullet)
		bullet.global_position = global_position

		var angle = angle_step * i
		var direction = Vector2(cos(angle), sin(angle))
		bullet.set_direction(direction)  # 이동 방향 설정

#func pattern_spiral():
#	var bullet_count = 10
#	var base_angle_step = 2 * PI / bullet_count
#
#	for j in range(10):  # n번의 발사 각도 변경
#		for i in range(bullet_count):
#			var bullet = bullet_scene.instantiate()
#			get_parent().add_child(bullet)
#			bullet.global_position = global_position
#
#			var angle_step = base_angle_step * (j + 1)  # 발사 각도 변경
#			var angle = angle_step * i
#			var direction = Vector2(cos(angle), sin(angle))
#			bullet.set_direction(direction)  # 이동 방향 설정

func get_player_position() -> Vector2:
	var player = $"../../main2/Player"
	if player:
		return player.global_position
	else:
		print("플레이어 노드를 찾을 수 없습니다.")
		return Vector2.ZERO

# Damage Logic
func take_damage(damage_amount):
	HP -= damage_amount
	animation.play("boss_hurt")
	$AudioStreamPlayer2D2.play()
	$AudioStreamPlayer2D.play()
	if HP <= 0:
		die()
		get_tree().change_scene_to_file("res://Game/stage2clear.tscn")

func die():
	# boss death
	queue_free()

# 캐릭터의 방향 업데이트
func update_direction(direction: Vector2):
	if direction.x != 0:
		facing_right = direction.x > 0
		animation.flip_h = facing_right  # Change sprite direction
