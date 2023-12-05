extends CharacterBody2D

# 보스 설정
@export var HP = 200
@export var speed = 200
var move_timer = Timer.new()
var is_firing = false
var fire_pause_timer = 0.0
@export var fire_pause_duration = 0.5

# 탄막 설정
@export var bullet_scene = preload("res://enemy_boss/boss_bullet.tscn")	# 보스 총알 scene 경로
@export var fire_rate = 2.0
var fire_timer = Timer.new()
var patterns = ["pattern_to_player", "pattern_circle"] # "pattern_spiral"]

func _ready():
	# 이동 타이머 설정
	add_child(move_timer)
	move_timer.wait_time = 1  # n초마다 방향 변경
	move_timer.connect("timeout", Callable(self, "_on_move_timer_timeout"))
	move_timer.start()

	# 탄막 발사 타이머 설정
	add_child(fire_timer)
	fire_timer.wait_time = fire_rate
	fire_timer.connect("timeout", Callable(self, "_on_fire_timer_timeout"))
	fire_timer.start()

func _on_move_timer_timeout():
	var random_direction = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()
	velocity = random_direction * speed  # 속도 업데이트

func _physics_process(delta):
	if is_firing:
		fire_pause_timer += delta
		if fire_pause_timer >= fire_pause_duration:
			# 일정 시간이 지난 후 보스의 움직임 복원
			is_firing = false
			fire_pause_timer = 0.0
			velocity = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized() * speed
	else:
		move_and_slide()

func _on_fire_timer_timeout():
	is_firing = true  # 탄막 발사 중 정지 상태로 설정
	velocity = Vector2.ZERO  # 속도 0으로 설정
	var pattern = patterns[randi() % patterns.size()]
	call(pattern)

# 탄막 패턴 관리
# 1. 플레이어에게 발사
# 2. 원형으로 발사
# 3. 나선형으로 발사 -> 보류. maybe 다른 패턴으로 대체?
func pattern_to_player():
	var bullet_instance = bullet_scene.instantiate()
	get_parent().add_child(bullet_instance)  # 보스의 부모 노드에 탄환 추가 (보스의 위치 이동에 탄환이 영향 받지 않아야 함)
	bullet_instance.global_position = global_position
	# 탄환의 크기 조절
	bullet_instance.scale = Vector2(2, 2)  # 원래 크기의 k배
	# 탄환의 속도 설정
	bullet_instance.speed = 1200  # 속도 = n 으로 설정
	# 탄환의 데미지 조정
	bullet_instance.damage = 20
	var target_direction = (get_player_position() - bullet_instance.global_position).normalized()
	bullet_instance.set_direction(target_direction)


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
	var player = get_node_or_null("../player_for_test")	# 플레이어 노드 경로
	if player:
		return player.global_position
	else:
		print("플레이어 노드를 찾을 수 없습니다.")
		return Vector2.ZERO

# Damage Logic
func take_damage(damage_amount):
	health -= damage_amount
	if health <= 0:
		die()

func die():
	# 보스 사망 처리 로직
	queue_free()
