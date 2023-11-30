extends RigidBody2D
class_name RedGift2

signal redgift_collected

func _on_red_box_body_entered(body):
	if body is RedGift2:
		emit_signal("redgift_collected")
		queue_free()
