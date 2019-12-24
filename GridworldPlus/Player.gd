extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var x = 0;
var y = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func move(world, dx, dy):
	if world.can_move(self, x + dx, y + dy):
		x += dx
		y += dy
