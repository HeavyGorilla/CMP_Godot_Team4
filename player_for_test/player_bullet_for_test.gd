extends Area2D

@export var damage = 10
@export var speed = 600  # 탄환의 속도 설정
var direction = Vector2.ZERO

func set_direction(new_direction: Vector2):
	direction = new_direction
	rotation = direction.angle()  # 탄환의 회전 방향 설정

func _process(delta):
	position += direction * speed * delta  # 탄환 이동

func _on_body_entered(body):
	if body.is_in_group("boss"):
		# boss와 충돌 시 처리
		# 데미지 처리 등
		print(body.name)
		body.take_damage(damage)
		queue_free()
