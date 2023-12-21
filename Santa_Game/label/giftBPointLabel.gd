# Manages the points of the second gift.
extends Label

var giftBPoints = 0
signal complete_giftB
signal giftBpointUp

func _ready():
	# Shows the number of remaining second gifts.
	text = "X"+str(1-giftBPoints)
	
	# Sends a signal to the player if the point of the second gift is 1 or more.
	if giftBPoints >= 1:
		emit_signal("complete_giftB")

# Raises the point of the second gift and send a signal to the PointLabel when the player delivers the second gift.
func _on_gift_b_1_gift_b_collected():
	giftBPoints = giftBPoints + 1
	emit_signal("giftBpointUp")
	_ready()
