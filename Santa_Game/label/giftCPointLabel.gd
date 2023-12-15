extends Label

var giftCPoints = 0
signal complete_giftC
signal giftCpointUp

func _ready():
	text = "X"+str(1-giftCPoints)
	
	if giftCPoints >= 1:
		print("giftC 완료")
		emit_signal("complete_giftC")

func _on_gift_c_1_gift_c_collected():
	giftCPoints = giftCPoints + 1
	emit_signal("giftCpointUp")
	_ready()

#func _on_gift_c_2_gift_c_collected():
#	giftCPoints = giftCPoints + 1
#	emit_signal("giftCpointUp")
#	_ready()
#
#func _on_gift_c_3_gift_c_collected():
#	giftCPoints = giftCPoints + 1
#	emit_signal("giftCpointUp")
#	_ready()
