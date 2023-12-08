extends Label

var Points = 0

func _ready():
	text = "Points: "+str(Points)

func _on_player_1_rudolph_rescued():
	Points = Points + 10
	_ready()

func _on_gift_a_point_label_gift_apoint_up():
	Points = Points + 10
	_ready()

func _on_gift_b_point_label_gift_bpoint_up():
	Points = Points + 10
	_ready()

func _on_gift_c_point_label_gift_cpoint_up():
	Points = Points + 10
	_ready()
