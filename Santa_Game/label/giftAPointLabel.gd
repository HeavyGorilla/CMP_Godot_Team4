extends Label

var giftAPoints = 0
signal complete_giftA

func _ready():
	text = "GiftA Points: "+str(giftAPoints)+"/3"
	
	if giftAPoints >= 1:
		print("giftA 완료")
		emit_signal("complete_giftA")

func _on_gift_a_1_gift_a_collected():
	giftAPoints = giftAPoints + 1
	_ready()

func _on_gift_a_2_gift_a_collected():
	giftAPoints = giftAPoints + 1
	_ready()

func _on_gift_a_3_gift_a_collected():
	giftAPoints = giftAPoints + 1
	_ready()
