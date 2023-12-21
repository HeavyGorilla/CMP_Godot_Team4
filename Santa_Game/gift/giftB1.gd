# Deals with the collision between the second gift and the chimney.
extends RigidBody2D
class_name GiftB1

signal giftB_collected

# Sends a signal to the giftBPointLabel when the second gift touches the chimney. 
func _on_gift_b_box_body_entered(body):
	if body is GiftB1:
		emit_signal("giftB_collected")
		queue_free()
