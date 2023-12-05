extends Area2D

@export var damage = 20
@export var speed = 500  # 탄막 속도
var direction = Vector2.ZERO  # 이동 방향
var is_direction_set = false # 직선 발사 때 이동 방향 바뀌지 않도록

func _ready():
	pass

func set_direction(new_direction: Vector2):
	if not is_direction_set:
		direction = new_direction.normalized()
		rotation = direction.angle()
		is_direction_set = true

func _process(delta):
	if is_direction_set:
		position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("santa"):
		# 플레이어와 충돌 시 처리
		# 데미지 처리 등
		print(body.name)
		body.take_damage(damage)
		queue_free()
