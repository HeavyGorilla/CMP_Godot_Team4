extends Label

var redPoints = 0

func _ready():
	text = "Red Points: "+str(redPoints)+"/3"


func _on_red_gift_1_redgift_collected():
	redPoints = redPoints + 1
	_ready()

func _on_red_gift_2_redgift_collected():
	redPoints = redPoints + 1
	_ready()

func _on_red_gift_3_redgift_collected():
	redPoints = redPoints + 1
	_ready()
