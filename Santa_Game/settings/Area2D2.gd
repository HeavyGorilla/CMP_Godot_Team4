# This script was created to decrease musics' volumes.
extends Area2D

func _ready():
	pass

func _process(delta):
	pass

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		Firstmusic.volume_db -= 3
		Stage1Music.volume_db -= 3
		Stage2Music.volume_db -= 3
		
