extends RigidBody2D
class_name GiftC1

signal giftC_collected

func _on_gift_c_box_body_entered(body):
	if body is GiftC1:
		emit_signal("giftC_collected")
		queue_free()
