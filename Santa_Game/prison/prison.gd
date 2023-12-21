# Manages areas of InteractionManger.
extends Area2D
class_name Prison

@export var action_name: String = "Rescue"

var interact: Callable = func():
	pass

func _on_body_entered(body):
	InteractionManager.register_area(self)
	set_process_input(true)
	
func _on_body_exited(body):
	InteractionManager.unregister_area(self)
	set_process_input(false)
