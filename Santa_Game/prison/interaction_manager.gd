# Prompts to press Space on top of the prison to rescue.
extends Node2D

@onready var santa = get_tree().get_first_node_in_group("santa")
@onready var label = $Label

const base_text = "[Space] to"

# Initializes an array to keep track of active Prison areas.
var active_areas = []
var can_interact = true

# Function to add a Prison area to the active areas list.
func register_area(area: Prison):
	active_areas.push_back(area)

# Function to remove a Prison area from the active areas list.
func unregister_area(area: Prison):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

# The _process function is called every frame, used here to update label visibility and position.
func _process(delta):
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		label.text = base_text + active_areas[0].action_name
		label.global_position = active_areas[0].global_position
		label.global_position.y -= 36
		label.global_position.x -= label.size.x / 2
		label.show()
	else:
		label.hide()

# Function to sort Prison areas by their distance to the 'santa' node.
func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = santa.global_position.distance_to(area1.global_position)
	var area2_to_player = santa.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player

# Function to handle input events, specifically for the "rescue" action.
func _input(event):
	if event.is_action_pressed("rescue") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			# Calls the interact function of the closest active area and awaits its completion.
			await active_areas[0].interact.call()
			
			# Re-enables interaction after the action is completed.
			can_interact = true
