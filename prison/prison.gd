extends Area2D
class_name Prison

@export var action_name: String = "Rescue"
var touched_rudolph = null
signal rudolph_rescued

var interact: Callable = func():
	pass

func _on_body_entered(body):
	InteractionManager.register_area(self)
	set_process_input(true)
	if touched_rudolph == null:
		touched_rudolph = body

func _on_body_exited(body):
	InteractionManager.unregister_area(self)
	set_process_input(false)
	if body == touched_rudolph:
		touched_rudolph = null

func _input(event):
	# 여기서 입력을 감지하고 처리합니다.
	if touched_rudolph != null and event.is_action_pressed("rescue"):
		emit_signal("rudolph_rescued")
		print("루돌프 구출")
		touched_rudolph.queue_free()
