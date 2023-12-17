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
		body.take_damage(damage)
		
	$AnimationPlayer.play("new_animation")
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.connect("animation_finished", Callable(self, "_on_animation_finished"))
		

func _on_animation_finished(anim_name):
	if anim_name == "new_animation":
		queue_free()
