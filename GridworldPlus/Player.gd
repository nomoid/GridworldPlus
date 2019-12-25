extends "res://Entity.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const move_cost = 0.5
const travel_time = 0.5
const action_depletion = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _get_action_depletion():
	return action_depletion

func _get_move_cost():
	return move_cost

func _get_travel_time():
	return travel_time