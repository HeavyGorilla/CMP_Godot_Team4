extends Area2D

@onready var ray_cast = $"../RayCast2D"

func _ready():
	ray_cast.enabled = true

# 플레이어가 시야 범위 내에 들어왔을 때 호출
func _on_body_entered(body):
	if body.is_in_group("player"):
		# RayCast2D의 타겟 위치를 플레이어 위치로 설정
		ray_cast.target_position = body.global_position - global_position
		ray_cast.force_raycast_update()
		if ray_cast.is_colliding() and ray_cast.get_collider() == body:
			print("플레이어 감지됨!")
			
			# 플레이어 == patrol visoin Mask
