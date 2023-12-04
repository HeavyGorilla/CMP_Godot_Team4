extends Label

var rudolphPoints = 0

func _ready():
	text = "Rudolph Points: "+str(rudolphPoints)+"/50"

func _on_prison_rudolph_rescued():
	rudolphPoints = rudolphPoints + 10
	_ready()

func _on_prison_2_rudolph_rescued():
	rudolphPoints = rudolphPoints + 10
	_ready()

func _on_prison_3_rudolph_rescued():
	rudolphPoints = rudolphPoints + 10
	_ready()

func _on_prison_4_rudolph_rescued():
	rudolphPoints = rudolphPoints + 10
	_ready()

func _on_prison_5_rudolph_rescued():
	rudolphPoints = rudolphPoints + 10
	_ready()

