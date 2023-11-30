extends RigidBody2D
class_name YellowGift3

signal yellowgift_collected

func _on_yellow_box_body_entered(body):
	if body is YellowGift3:
		emit_signal("yellowgift_collected")
		queue_free()
		
