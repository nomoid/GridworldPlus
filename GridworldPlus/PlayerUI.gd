extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (NodePath) var player

const full_health = 100.0
const full_action = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player:
		var node = get_node(player)
		$HealthBar.value = node.health * 100 / full_health
		$ActionBar.value = node.action * 100 / full_action
