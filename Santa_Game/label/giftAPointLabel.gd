# Manages the points of the first gift.
extends Label

var giftAPoints = 0
signal complete_giftA
signal giftApointUp

func _ready():
	# Shows the number of remaining first gifts.
	text = "X"+str(1-giftAPoints)
	
	# Sends a signal to the player if the point of the first gift is 1 or more.
	if giftAPoints >= 1:
		emit_signal("complete_giftA")

# Raises the point of the first gift and send a signal to the PointLabel when the player delivers the first gift.
func _on_gift_a_1_gift_a_collected():
	giftAPoints = giftAPoints + 1
	emit_signal("giftApointUp")
	_ready()
