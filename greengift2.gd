extends RigidBody2D
class_name GreenGift2

signal greengift_collected

func _on_green_box_body_entered(body):
	if body is GreenGift2:
		emit_signal("greengift_collected")
		queue_free()
		
