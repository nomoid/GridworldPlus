extends Node2D

var x = 0
var y = 0
var displayX = 0
var displayY = 0

var health = 100
var action = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	_update_action(delta)
	_animate(delta)

func _update_action(delta):
	if action > 0:
		action -= _get_action_depletion() * delta
	if action < 0:
		action = 0

func _animate(delta):
	_animate_move(delta)

#Move animation
var animateStartX = 0
var animateStartY = 0
var animateEndX = 0
var animateEndY = 0
var animateTotalTime = 0
var animateTimeLeft = 0
func _animate_move(delta):
	if animateTimeLeft < 0:
		animateTimeLeft = 0
		displayX = x
		displayY = y
	if animateTimeLeft > 0:
		var weight = 1 - animateTimeLeft / animateTotalTime
		var step = smoothstep(0, 1, weight)
		var resX = step * (animateEndX - animateStartX) + animateStartX
		var resY = step * (animateEndY - animateStartY) + animateStartY
		displayX = resX
		displayY = resY
		animateTimeLeft -= delta

# Movement
func move(world, dx, dy):
	if can_make_move(world, x + dx, y + dy):
		_start_move_animation(x, y, dx, dy)
		action = _get_move_cost()
		x += dx
		y += dy

func _start_move_animation(x, y, dx, dy):
	animateStartX = x
	animateStartY = y
	animateEndX = x + dx
	animateEndY = y + dy
	animateTotalTime = _get_travel_time()
	animateTimeLeft = _get_travel_time()

func can_make_move(world, x, y):
	if action > 0:
		return false
	if not world.can_move(self, x, y):
		return false
	return true

# Abstract functions
func _get_action_depletion():
	pass

func _get_move_cost():
	pass

func _get_travel_time():
	pass