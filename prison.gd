extends Area2D
class_name Prison

@export var action_name: String = "Resque"

var interact: Callable = func():
	pass
	
func _on_body_entered(body):
	InteractionManager.register_area(self)
	if body is santa:
		if Input.is_action_pressed("resque"):
			queue_free()

func _on_prison_5_body_exited(body):
	InteractionManager.unregister_area(self)
	if body is santa:
		if Input.is_action_pressed("resque"):
			queue_free()
