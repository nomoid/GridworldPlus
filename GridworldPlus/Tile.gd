extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const textureWidth = 1024;
const textureHeight = 1024;

const name_map = {
	"d1": "desert1",
	"d2": "desert2",
	"d3": "desert3",
	"d4": "desert4",
	"dm1": "desertmountain1",
	"dm2": "desertmountain2",
	"dm3": "desertmountain3",
	"dm4": "desertmountain4",
	"dv1": "desertvolcano1",
	"dv2": "desertvolcano2",
	"f1": "forest1",
	"f2": "forest2",
	"g1": "grass1",
	"g2": "grass2",
	"g3": "grass3",
	"g4": "grass4",
	"h1": "hill1",
	"h2": "hill2",
	"h3": "hill3",
	"h4": "hill4",
	"i1": "ice1",
	"i2": "ice2",
	"im1": "icymountain1",
	"im2": "icymountain2",
	"im3": "icymountain3",
	"m1": "mountain1",
	"m2": "mountain2",
	"m3": "mountain3",
	"w1": "water1",
	"w2": "water2"}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_width():
	return $Image.transform.get_scale().x * textureWidth
	
func get_height():
	return $Image.transform.get_scale().y * textureHeight
	
func set_tile(tile):
	var tile_name = tile
	if name_map.has(tile):
		tile_name = name_map[tile]
	$Image.animation = tile_name

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
