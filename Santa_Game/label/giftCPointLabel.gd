# Manages the points of the third gift.
extends Label

var giftCPoints = 0
signal complete_giftC
signal giftCpointUp

func _ready():
	# Shows the number of remaining third gifts.
	text = "X"+str(1-giftCPoints)
	
	# Sends a signal to the player if the point of the third gift is 1 or more.
	if giftCPoints >= 1:
		emit_signal("complete_giftC")

# Raises the point of the third gift and send a signal to the PointLabel when the player delivers the third gift.
func _on_gift_c_1_gift_c_collected():
	giftCPoints = giftCPoints + 1
	emit_signal("giftCpointUp")
	_ready()
