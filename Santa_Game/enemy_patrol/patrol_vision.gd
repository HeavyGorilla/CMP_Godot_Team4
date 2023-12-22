'''
The 'patrol_vision' scene will manage the core features for 'patrol's eye-sight.
It detects the player and checks whether an obstacle is in the way or not using 'RayCast2D'
This script is for 'patrol_vision'
'''

extends Area2D

@onready var ray_cast = $"../RayCast2D"
var vision_distance = 950

func _ready():
	ray_cast.enabled = true

# Call when player(group: 'santa') enters the vision
func _on_body_entered(body):
	if body.is_in_group("santa"):
		update_ray_cast_direction(body)

func update_ray_cast_direction(target_body):
	# Setting the RayCast2D's cast_to based on the current direction of the guard
	var direction = (target_body.global_position - global_position).normalized()
	ray_cast.target_position = direction * vision_distance
	ray_cast.force_raycast_update()

	# RayCast2D: Check whether an obstacle is in the way or not
	if ray_cast.is_colliding() and ray_cast.get_collider() == target_body:
		print("플레이어 감지됨!")
		get_tree().change_scene_to_file("res://game/gameover.tscn")
