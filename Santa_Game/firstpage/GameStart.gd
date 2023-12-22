#This GDScript is for starting game.
extends Area2D

func _ready():
	pass

func _process(delta):
	pass

#If you press this button with left mouse move to level1 scene and music change.
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		get_tree().change_scene_to_file("res://level/Level1.tscn")
		Firstmusic.stop()
		Stage1Music.play_sound()
