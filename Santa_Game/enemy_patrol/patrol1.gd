extends CharacterBody2D

@export var speed = 200
var patrol_vision_scene = preload("res://enemy_patrol/patrol_vision.tscn")
var patrol_vision
var rotation_speed = 7.0  # 회전 속도 조절

# Path2D
var path_nodes = [] # 묙표 노드 위치 저장 인덱
var current_node_index = 0  # 현재 목표 노드 인덱스

# Patrol Animation
@onready var animation = $AnimatedSprite2D
var facing_right = false  # 캐릭터가 오른쪽을 바라보고 있는지 여부

func _ready():
	if patrol_vision_scene:
		patrol_vision = patrol_vision_scene.instantiate()
		add_child(patrol_vision)
	else:
		print("경고: patrol_vision 장면을 로드할 수 없음.")
		
	# Patrol에 따라 달라짐: range, path#
	for i in range(1, 13):
		var node = get_node("../path1/Marker2D" + str(i))
		path_nodes.append(node.position)

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
		
	# Patrol AnimatedSprite2D direction
	update_direction(direction)
	
	# 시야의 방향 업데이트
	if patrol_vision and velocity != Vector2.ZERO:
		patrol_vision.global_position = global_position  # 경비병과 같은 위치로 설정
		var direction_angle = atan2(velocity.y, velocity.x)
		patrol_vision.rotation = lerp_angle(patrol_vision.rotation, direction_angle, rotation_speed * delta)

# 캐릭터의 방향 업데이트
func update_direction(direction: Vector2):
	if direction.x != 0:
		facing_right = direction.x > 0
		animation.flip_h = facing_right  # 스프라이트 방향 변경
