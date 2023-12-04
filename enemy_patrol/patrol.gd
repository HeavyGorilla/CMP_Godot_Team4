extends CharacterBody2D

var speed = 100
var patrol_vision_scene = preload("res://enemy_patrol/patrol_vision.tscn")
var patrol_vision
var rotation_speed = 5.0  # 회전 속도 조절

# 아래는 test용 변수
var move_timer = Timer.new()

func _ready():
	if patrol_vision_scene:
		patrol_vision = patrol_vision_scene.instantiate()
		add_child(patrol_vision)
	else:
		print("경고: patrol_vision 장면을 로드할 수 없음.")
		
	# test용 이동
	add_child(move_timer)
	move_timer.wait_time = 1  # n초마다 방향 변경
	move_timer.connect("timeout", Callable(self, "_on_move_timer_timeout"))
	move_timer.start()

func _process(delta):
	# 이동 로직
	# Navigator 사용
	# ...

	# 시야의 방향 업데이트
	if patrol_vision and velocity != Vector2.ZERO:
		patrol_vision.global_position = global_position  # 경비병과 같은 위치로 설정
		var direction_angle = atan2(velocity.y, velocity.x)
		patrol_vision.rotation = lerp_angle(patrol_vision.rotation, direction_angle, rotation_speed * delta)


# test용 이동 함수. 랜덤으로 이동. 시야의 방향 전환 확인용
func _on_move_timer_timeout():
	var random_direction = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()
	velocity = random_direction * speed  # 속도 업데이트
func _physics_process(_delta):
	move_and_slide()
