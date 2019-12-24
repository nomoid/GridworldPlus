extends Node2D

export (PackedScene) var Tile 

const cameraSpeed = 1000

var tileWidth;
var tileHeight;

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
	# Assume all tiles have same width/height
	var defaultTile = Tile.instance()
	tileWidth = defaultTile.get_width()
	tileHeight = defaultTile.get_height()
	# Setup tiles
	for y in range(len(map)):
		for x in range(len(map[y])):
			var tile = Tile.instance()
			tile.position = get_tile_position(x, y)
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
	if Input.is_action_just_pressed("player_left"):
		$Player.move(self, -1, 0)
	if Input.is_action_just_pressed("player_right"):
		$Player.move(self, 1, 0)
	if Input.is_action_just_pressed("player_up"):
		$Player.move(self, 0, -1)
	if Input.is_action_just_pressed("player_down"):
		$Player.move(self, 0, 1)
	# Update player position
	$Player.position = get_tile_position($Player.x, $Player.y)

func get_tile_position(x, y):
	return Vector2(tileWidth * (x + 0.5), tileHeight * (y + 0.5))

func can_move(character, x, y):
	if x < 0 || y < 0:
		return false
	if y >= len(map):
		return false
	var row = map[y]
	if x >= len(row):
		return false
	var tile = row[x]
	return can_move_to_tile(character, tile)

func can_move_to_tile(character, tile):
	if tile == "w2":
		return false
	return true
