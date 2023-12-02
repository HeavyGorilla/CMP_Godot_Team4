extends CharacterBody2D

#@onready var camera = $"../Camera2D"  # Camera2D 노드 참조
#var default_zoom = Vector2(1, 1)  # 기본 줌 수준
#var zoomed_in_zoom = Vector2(1.2, 1.2)  # 확대될 때의 줌 수준
#var zoom_duration = 0.2  # 줌 상태 지속 시간

@onready var ray_cast = $RayCast2D
@export var ammo : PackedScene
var enemy
@onready var animated_sprite = $AnimatedSprite2D

var is_interacting_with_box = false
var is_shooting = false
var can_shoot = true

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
	enemy = get_parent().get_node("enemy")
	animated_sprite.connect("animation_finished", Callable(self, "_on_AnimatedSprite2D_animation_finished"))

func _physics_process(_delta):
	$RudolfBar.value = Rudolf_get
	$HealthBar.value = health
	velocity = Input.get_vector("left", "right", "up", "down") * 150
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
	
	if Input.is_action_just_pressed("shoot") and can_shoot:
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
#		zoom_in_camera()
		_shoot()
		
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


#func zoom_in_camera():
#	camera.zoom = zoomed_in_zoom
#	camera.global_position = get_global_mouse_position()
#	$"../ZoomTimer".start(zoom_duration)  # ZoomTimer는 Timer 노드의 이름입니다.
#
#func _on_ZoomTimer_timeout():
#	camera.zoom = default_zoom
#	camera.global_position = global_position

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


func _on_area_2d_area_entered(area):
	is_interacting_with_box = true

func _on_area_2d_area_exited(area):
	is_interacting_with_box = false

func _on_reload_timer_timeout():
	can_shoot = true
