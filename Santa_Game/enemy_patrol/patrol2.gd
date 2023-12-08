extends CharacterBody2D

@export var speed = 200
var patrol_vision_scene = preload("res://enemy_patrol/patrol_vision.tscn")
var patrol_vision
var rotation_speed = 7.0  # 회전 속도 조절

# Path2D
var path_nodes = [] # 묙표 노드 위치 저장 인덱
var current_node_index = 0  # 현재 목표 노드 인덱스스

# 아래는 test용 변수
#var move_timer = Timer.new()

func _ready():
	if patrol_vision_scene:
		patrol_vision = patrol_vision_scene.instantiate()
		add_child(patrol_vision)
	else:
		print("경고: patrol_vision 장면을 로드할 수 없음.")
		
	# Patrol에 따라 달라짐: range, path#
	for i in range(1, 25):
		var node = get_node("../path2/Marker2D" + str(i))
		path_nodes.append(node.position)

	# test용 이동
#	add_child(move_timer)
#	move_timer.wait_time = 1  # n초마다 방향 변경
#	move_timer.connect("timeout", Callable(self, "_on_move_timer_timeout"))
#	move_timer.start()

func _process(delta):
	# 이동 로직
	var target_position = path_nodes[current_node_index]
	var distance_to_target = position.distance_to(target_position)
	var move_step = speed * delta


	# velocity를 통해 시야 방향 조절
	var direction = (target_position - position).normalized()
	velocity = direction * speed

	if distance_to_target <= move_step:
		position = target_position
		current_node_index += 1
		if current_node_index >= path_nodes.size():
			current_node_index = 0
	else:
		position += direction * move_step

	# 시야의 방향 업데이트
	if patrol_vision and velocity != Vector2.ZERO:
		patrol_vision.global_position = global_position  # 경비병과 같은 위치로 설정
		var direction_angle = atan2(velocity.y, velocity.x)
		patrol_vision.rotation = lerp_angle(patrol_vision.rotation, direction_angle, rotation_speed * delta)

# test용 이동 함수. 랜덤으로 이동. 시야의 방향 전환 확인용
#func _on_move_timer_timeout():
#	var random_direction = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()
#	velocity = random_direction * speed  # 속도 업데이트
#func _physics_process(_delta):
#	move_and_slide()
