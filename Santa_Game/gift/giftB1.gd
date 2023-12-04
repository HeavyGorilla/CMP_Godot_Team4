extends RigidBody2D
class_name GiftB1

signal giftB_collected

func _on_gift_b_box_body_entered(body):
	if body is GiftB1:
		emit_signal("giftB_collected")
		queue_free()