extends Label

var giftBPoints = 0
signal complete_giftB

func _ready():
	text = "GiftB Points: "+str(giftBPoints)+"/3"
	
	if giftBPoints >= 1:
		print("giftB 완료")
		emit_signal("complete_giftB")

func _on_gift_b_1_gift_b_collected():
	giftBPoints = giftBPoints + 1
	_ready()

func _on_gift_b_2_gift_b_collected():
	giftBPoints = giftBPoints + 1
	_ready()

func _on_gift_b_3_gift_b_collected():
	giftBPoints = giftBPoints + 1
	_ready()
