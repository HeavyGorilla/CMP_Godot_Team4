extends CharacterBody2D

@export var HP = 100
@export var speed = 500
@export var bullet_scene = preload("res://player_for_test/player_bullet_for_test.tscn")
@export var fire_rate: float = 0.5  # 탄환 발사 사이의 대기 시간 (sec)
var last_fire_time: float = 0  # 마지막 발사 시간

# Player Movement
func get_input():
	# get input vector based on two axes: left-right and up-down
	var input_direction = Input.get_vector("Left", "Right","Up", "Down")
	# velocity vector is a longer version of input_direction
	velocity = input_direction * speed
	
func _physics_process(_delta):
	get_input()
	# move player based on the velocity that we set above
	move_and_slide()

# Player Bullet

func _ready():
	last_fire_time = -fire_rate  # 게임 시작 시 즉시 발사할 수 있도록 -fire_rate로 초기화

func _process(_delta):
	if Input.is_action_just_pressed("Left_Click") and can_fire():
		fire_bullet()
		last_fire_time = Time.get_ticks_msec() / 1000.0  # 마지막 발사 시간 갱신

func can_fire() -> bool:
	var current_time = Time.get_ticks_msec() / 1000.0
	return current_time - last_fire_time >= fire_rate

func fire_bullet():
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)  # 탄환을 현재 씬에 추가
	bullet.global_position = global_position  # 탄환의 시작 위치를 플레이어의 위치로 설정

	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - global_position).normalized()
	bullet.set_direction(direction)

func take_damage(damage_amount):
	HP -= damage_amount
	if HP <= 0:
		die()

func die():
	# 플레이어 사망 처리 로직
	queue_free()

func delete_boss():
	var boss = get_node("../boss")  # 보스 노드 경로
	if boss:
		boss.queue_free()

# heal
func heal(amount):
	HP += amount
