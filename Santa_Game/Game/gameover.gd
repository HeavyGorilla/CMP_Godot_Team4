# This script was created to turn off level1 and 2 songs due to you lose the game.
extends StaticBody2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Stage1Music.stop()
	Stage2Music.stop()

func _process(delta):
	pass
