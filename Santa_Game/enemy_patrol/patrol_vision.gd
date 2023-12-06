extends Area2D

@onready var ray_cast = $"../RayCast2D"
var vision_distance = 750

func _ready():
	ray_cast.enabled = true

# 플레이어가 시야 범위 내에 들어왔을 때 호출
func _on_body_entered(body):
	if body.is_in_group("santa"):
		update_ray_cast_direction(body)

func update_ray_cast_direction(target_body):
	# 경비병의 현재 방향에 따라 RayCast2D의 cast_to 설정
	var direction = (target_body.global_position - global_position).normalized()
	ray_cast.target_position = direction * vision_distance
	ray_cast.force_raycast_update()

	# RayCast2D 감지 확인
	if ray_cast.is_colliding() and ray_cast.get_collider() == target_body:
		print("플레이어 감지됨!")
