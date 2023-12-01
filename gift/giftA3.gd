extends RigidBody2D
class_name GiftA3

signal giftA_collected

func _on_gift_a_box_body_entered(body):
	if body is GiftA3:
		emit_signal("giftA_collected")
		queue_free()
