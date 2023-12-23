# This is the script that move from instruction1 to main.
extends Area2D

func _ready():
	pass

func _process(delta):
	pass

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		get_tree().change_scene_to_file("res://firstpage/main.tscn")
