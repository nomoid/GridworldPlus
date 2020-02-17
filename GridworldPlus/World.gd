extends Node2D

export (PackedScene) var Tile
export (PackedScene) var Enemy

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

var entities = []

var do_process_var = true

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set random seed
	randomize()
	# Assume all tiles have same width/height
	var defaultTile = Tile.instance()
	tileWidth = defaultTile.get_width()
	tileHeight = defaultTile.get_height()
	# Setup tiles
	for y in range(len(map)):
		for x in range(len(map[y])):
			var tile = Tile.instance()
			tile.position = get_tile_position(x, y)
			# Set the tile's displayed image according to the map
			tile.set_tile(map[y][x])
			add_child(tile)
	add_entity($Player)
	add_enemy(3, 3)

func add_entity(entity):
	entity.set_world(self)
	entities.push_back(entity)

func add_enemy(x, y):
	var enemy = Enemy.instance()
	enemy.set_pos(x, y)
	add_entity(enemy)
	add_child(enemy)

func _process(delta):
	update_do_process()
	if Input.is_action_pressed("ui_left"):
		$Camera2D.position -= Vector2(cameraSpeed,0) * delta
	if Input.is_action_pressed("ui_right"):
		$Camera2D.position += Vector2(cameraSpeed,0) * delta
	if Input.is_action_pressed("ui_up"):
		$Camera2D.position -= Vector2(0,cameraSpeed) * delta
	if Input.is_action_pressed("ui_down"):
		$Camera2D.position += Vector2(0,cameraSpeed) * delta
	if Input.is_action_just_pressed("player_left"):
		$Player.try_move(-1, 0)
	if Input.is_action_just_pressed("player_right"):
		$Player.try_move(1, 0)
	if Input.is_action_just_pressed("player_up"):
		$Player.try_move(0, -1)
	if Input.is_action_just_pressed("player_down"):
		$Player.try_move(0, 1)
	# Update entity position
	for entity in entities:
		entity.position = get_tile_position(entity.displayX, entity.displayY)

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
	if not can_move_to_tile(character, tile):
		return false
	# Check entity locations
	for entity in entities:
		if entity != character and entity.x == x and entity.y == y:
			return false
	return true

func can_move_to_tile(character, tile):
	# Prevent movement to water tiles
	if tile == "w2":
		return false
	return true

func update_do_process():
	do_process_var = !$Player.action_available()

func do_process():
	return do_process_var
