# Deals with the collision between the first gift and the chimney.
extends RigidBody2D
class_name GiftA1

signal giftA_collected

# Sends a signal to the giftAPointLabel when the first gift touches the chimney.
func _on_gift_a_box_body_entered(body):
	if body is GiftA1:
		emit_signal("giftA_collected")
		queue_free()
