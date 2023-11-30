extends RigidBody2D
class_name YellowGift2

signal yellowgift_collected

func _on_yellow_box_body_entered(body):
	if body is YellowGift2:
		emit_signal("yellowgift_collected")
		queue_free()
		
