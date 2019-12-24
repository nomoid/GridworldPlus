extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var x = 0
var y = 0

const move_cost = 0.5
const action_depletion = 1.0

var health = 100
var action = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if action > 0:
		action -= action_depletion * delta
	if action < 0:
		action = 0

func move(world, dx, dy):
	if can_move(world, dx, dy):
		action = move_cost
		x += dx
		y += dy

func can_move(world, dx, dy):
	if action > 0:
		return false
	if not world.can_move(self, x + dx, y + dy):
		return false
	return true