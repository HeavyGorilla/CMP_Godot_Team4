extends Label

var yellowPoints = 0

func _ready():
	text = "Yellow Points: "+str(yellowPoints)+"/3"

func _on_yellow_gift_1_yellowgift_collected():
	yellowPoints = yellowPoints + 1
	_ready()
