extends Label

var greenPoints = 0

func _ready():
	text = "Green Points: "+str(greenPoints)+"/3"

func _on_green_gift_1_greengift_collected():
	greenPoints = greenPoints + 1
	_ready()


func _on_green_gift_2_greengift_collected():
	greenPoints = greenPoints + 1
	_ready()


func _on_green_gift_3_greengift_collected():
	greenPoints = greenPoints + 1
	_ready()
