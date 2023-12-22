#This GDScript is for game instruction.
extends Area2D

func _ready():
	pass

func _process(delta):
	pass

#If you press this button with left mouse move to instruction scene.
func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		get_tree().change_scene_to_file("res://instruction/instruction1.tscn")
