extends "res://Entity.gd"

const move_cost = 3.1415926
const travel_time = 0.5
const action_depletion = 1.0

var action_list = [
	["_move", [0, 1]],
	["_move", [1, 0]],
	["_move", [0, -1]],
	["_move", [-1, 0]]
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if action_available():
		perform_random_action()
	if $"/root/Global".debug:
		_debug_label()

func _debug_label():
	$DebugLabel.visible = true
	$DebugLabel.text = "Action: %f" % action

func perform_random_action():
	var ordering = range(len(action_list))
	ordering.shuffle()
	for action_index in ordering:
		if not action_available():
			break
		run_action(action_list[action_index])
	
func _get_action_depletion():
	return action_depletion

func _get_move_cost():
	return move_cost

func _get_travel_time():
	return travel_time
