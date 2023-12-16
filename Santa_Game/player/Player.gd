extends CharacterBody2D

class_name santa2

@onready var ray_cast = $RayCast2D
@export var ammo : PackedScene
@onready var animated_sprite = $AnimatedSprite2D
var giftpoints = 0

var is_interacting_with_box = false
var is_shooting = false
var can_shoot = true

var charge = 0  # 기 축적 변수
var max_charge = 60  # 최대 기 축적량
var charge_rate = 60  # 초당 기 축적량


enum Direction { UP, DOWN, LEFT, RIGHT }
var current_direction = Direction.DOWN

@onready var reload_timer = $ReloadTimer

# Rudolf
var Rudolf_get = 0
var Rudolfs = 3
var energy_per_Rudolf = 33

# health
var health = 100

func _ready():
	animated_sprite.connect("animation_finished", Callable(self, "_on_AnimatedSprite2D_animation_finished"))

func _physics_process(_delta):
	$EnergyBar.value = charge
	$HealthBar.value = health

	velocity = Input.get_vector("left", "right", "up", "down") * 450
	move_and_slide()

	if !is_interacting_with_box:
		if not is_shooting:
			if Input.is_action_pressed("up"):
				current_direction = Direction.UP
				animated_sprite.play("up_walk")
			elif Input.is_action_pressed("down"):
				current_direction = Direction.DOWN
				animated_sprite.play("down_walk")
			elif Input.is_action_pressed("left"):
				current_direction = Direction.LEFT
				animated_sprite.flip_h = false
				animated_sprite.play("left_walk")
			elif Input.is_action_pressed("right"):
				current_direction = Direction.RIGHT
				animated_sprite.flip_h = true
				animated_sprite.play("left_walk")
			else:
				animated_sprite.stop()

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and can_shoot:
		charge += charge_rate * _delta
		charge = min(charge, max_charge)  # 최대 축적량을 넘지 않도록 함

	if Input.is_action_just_released("shoot") and can_shoot:
		is_shooting = true  # Set to true when shooting starts
		can_shoot = false  # Disable shooting until reload
		reload_timer.start()
		match current_direction:
			Direction.UP:
				animated_sprite.play("up_attack")
			Direction.DOWN:
				animated_sprite.play("down_attack")
			Direction.LEFT:
				animated_sprite.flip_h = false
				animated_sprite.play("left_attack")
			Direction.RIGHT:
				animated_sprite.flip_h = true
				animated_sprite.play("left_attack")
		_shoot()
		charge = 0  # 기 축적량 초기화

		
	if is_interacting_with_box:
		if not is_shooting:
			if Input.is_action_pressed("up"):
				current_direction = Direction.UP
				animated_sprite.play("up_box")
			elif Input.is_action_pressed("down"):
				current_direction = Direction.DOWN
				animated_sprite.play("down_walk")
			elif Input.is_action_pressed("left"):
				current_direction = Direction.LEFT
				animated_sprite.flip_h = false
				animated_sprite.play("left_box")
			elif Input.is_action_pressed("right"):
				current_direction = Direction.RIGHT
				animated_sprite.flip_h = true
				animated_sprite.play("left_box")
			else:
				animated_sprite.stop()


@onready var bullet_spawn_point_up = $AnimatedSprite2D/BulletSpawnPointUp
@onready var bullet_spawn_point_down = $AnimatedSprite2D/BulletSpawnPointDown
@onready var bullet_spawn_point_down2 = $AnimatedSprite2D/BulletSpawnPointDown2
@onready var bullet_spawn_point_left = $AnimatedSprite2D/BulletSpawnPointLeft
@onready var bullet_spawn_point_right = $AnimatedSprite2D/BulletSpawnPointRight

func _shoot():
	var bullet = ammo.instantiate()
	var spawn_point = get_spawn_point()
	bullet.position = spawn_point.global_position
	bullet.direction = (get_global_mouse_position() - global_position).normalized()
	get_tree().current_scene.add_child(bullet)
	bullet.speed += charge*10

func get_spawn_point():
	match current_direction:
		Direction.UP:
			if animated_sprite.flip_h == false:
				return bullet_spawn_point_up
			if animated_sprite.flip_h == true:
				return bullet_spawn_point_right
		Direction.DOWN:
			if animated_sprite.flip_h == false:
				return bullet_spawn_point_down
			if animated_sprite.flip_h == true:
				return bullet_spawn_point_down2
		Direction.LEFT:
			return bullet_spawn_point_left
		Direction.RIGHT:
			return bullet_spawn_point_right

func _on_AnimatedSprite2D_animation_finished():  # New function to handle the signal
	if is_shooting:
		is_shooting = false  # Reset the flag when the animation is finished

func _on_reload_timer_timeout():
	can_shoot = true

func take_damage(damage):
	health -= damage
	
	if health <= 0:
		get_tree().change_scene_to_file("res://Game/gameover.tscn")
