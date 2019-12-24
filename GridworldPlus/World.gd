extends Node2D

export (PackedScene) var Tile 

const cameraSpeed = 1000

const map = [
	["h3", "h1", "g1", "g1", "g1", "g1", "g1", "g1", "g1", "g1"],
	["h2", "h1", "g1", "g1", "g1", "g1", "g1", "g1", "g1", "d1"],
	["h1", "g1", "g1", "g1", "g1", "g1", "g1", "g1", "d1", "d1"],
	["g1", "g1", "g1", "g1", "g1", "g1", "g1", "g1", "d1", "w2"],
	["g1", "g1", "g1", "g1", "g1", "g1", "g1", "g1", "d1", "w2"],
	["g1", "g1", "g1", "g1", "g1", "g1", "g1", "g1", "d1", "w2"],
	["g1", "g1", "g1", "g1", "g1", "g1", "g1", "d1", "w2", "w2"],
	["f1", "f1", "f1", "g1", "g1", "g1", "g1", "g1", "d1", "d1"],
	["f2", "f2", "f2", "f1", "g1", "g1", "g1", "g1", "g1", "g1"],
	["f2", "f2", "f2", "f2", "f1", "g1", "g1", "g1", "g1", "g1"]
]

# Called when the node enters the scene tree for the first time.
func _ready():
	for y in range(len(map)):
		for x in range(len(map[y])):
			var tile = Tile.instance()
			tile.position = Vector2(tile.get_width() * (x + 0.5), tile.get_height() * (y + 0.5))
			tile.set_tile(map[y][x])
			add_child(tile)

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		$Camera2D.position -= Vector2(cameraSpeed,0) * delta
	if Input.is_action_pressed("ui_right"):
		$Camera2D.position += Vector2(cameraSpeed,0) * delta
	if Input.is_action_pressed("ui_up"):
		$Camera2D.position -= Vector2(0,cameraSpeed) * delta
	if Input.is_action_pressed("ui_down"):
		$Camera2D.position += Vector2(0,cameraSpeed) * delta
