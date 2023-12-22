#This GDScript is for mainpage backgroundmusic.
extends StaticBody2D


func _ready():
	#If Firstmusic is not currently playing start playing Firstmusic.
	if Firstmusic.playing == false:
		Firstmusic.play()

func _process(delta):
	pass
