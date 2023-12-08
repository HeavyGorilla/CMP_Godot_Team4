extends Area2D
 
var direction : Vector2 = Vector2.RIGHT
var speed : float = 300
var damage = 10 

func _physics_process(delta):
	position += direction * speed * delta
 
 
func _on_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body.is_in_group("boss"):
		# 플레이어와 충돌 시 처리
		# 데미지 처리 등
		print(body.name)
		body.take_damage(damage)
		queue_free()
