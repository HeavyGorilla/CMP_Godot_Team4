extends Label

var giftCPoints = 0
signal complete_giftC

func _ready():
	text = "GiftC Points: "+str(giftCPoints)+"/3"
	
	if giftCPoints >= 3:
		print("giftC 완료")
		emit_signal("complete_giftC")

func _on_gift_c_1_gift_c_collected():
	giftCPoints = giftCPoints + 1
	_ready()

func _on_gift_c_2_gift_c_collected():
	giftCPoints = giftCPoints + 1
	_ready()

func _on_gift_c_3_gift_c_collected():
	giftCPoints = giftCPoints + 1
	_ready()