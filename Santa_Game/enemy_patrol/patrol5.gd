'''
'patrol' scene will instantiate the 'patrol_vision' scene and manage its directions followed by 'patrol's direction.
Used 'Marker2D' in the level scene to define 'the patrol's path.

The script is for 'patrol' scenes. Generally, it will manage the following features:
1. Patrol Path Navigation:
	It guides a character to follow a predefined path of nodes, automatically moving and rotating along this path.

2. Dynamic Vision System:
	Integrates a vision system that aligns with the character's position and direction, likely for detecting other entities.

3. Sprite Animation Control:
	Manages the character's sprite orientation, flipping it to match the movement direction.
'''


extends CharacterBody2D

@export var speed = 200
var patrol_vision_scene = preload("res://enemy_patrol/patrol_vision.tscn")
var patrol_vision
var rotation_speed = 7.0  # Rotation speed of the 'patrol'

# Path of the patrol
var path_nodes = [] # Index to store path node positions
var current_node_index = 0  # Current target node index

# Patrol Animation
@onready var animation = $AnimatedSprite2D
var facing_right = false  # Whether the character is facing right

func _ready():
	if patrol_vision_scene:
		patrol_vision = patrol_vision_scene.instantiate()
		add_child(patrol_vision)
	else:
		print("경고: patrol_vision 장면을 로드할 수 없음.")
		
	# Differs by the Patrol: range, path#
	for i in range(1, 9):
		var node = get_node("../path5/Marker2D" + str(i))
		path_nodes.append(node.position)

	# test용 이동
#	add_child(move_timer)
#	move_timer.wait_time = 1  # n초마다 방향 변경
#	move_timer.connect("timeout", Callable(self, "_on_move_timer_timeout"))
#	move_timer.start()

func _process(delta):
	# Movement logic
	var target_position = path_nodes[current_node_index]
	var distance_to_target = position.distance_to(target_position)
	var move_step = speed * delta


	# Adjust the direction of view through velocity
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
	
	# Update the direction of 'patrol_vision'
	if patrol_vision and velocity != Vector2.ZERO:
		patrol_vision.global_position = global_position  # Set to the same position as the patrol
		var direction_angle = atan2(velocity.y, velocity.x)
		patrol_vision.rotation = lerp_angle(patrol_vision.rotation, direction_angle, rotation_speed * delta)

# Update the direction of the character
func update_direction(direction: Vector2):
	if direction.x != 0:
		facing_right = direction.x > 0
		animation.flip_h = facing_right  # Change sprite direction
