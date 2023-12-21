# Deals with the collision between the third gift and the chimney.
extends RigidBody2D
class_name GiftC1

signal giftC_collected

# Send a signal to the giftCPointLabel when the third gift touches the chimney.
func _on_gift_c_box_body_entered(body):
	if body is GiftC1:
		emit_signal("giftC_collected")
		queue_free()
