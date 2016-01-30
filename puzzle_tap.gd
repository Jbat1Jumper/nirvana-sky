
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

var camera = null
var camera_offset = null

var button = null
var monk = null

var target_opacity = 0.0
var start_opacity = 0.0
var fade_time_elapsed = 0.0
var fade_time = 0.5  # seg

func _ready():
	camera = get_node("../camera")
	camera_offset = get_pos() - camera.get_pos()
	
	button = get_node("button")
	monk = get_node("../monk")
	
	set_process(true)

func _process(deltatime):
	check_input(deltatime)
	lerp_opacity(deltatime)
	move_puzzle(deltatime)
	
func move_puzzle(deltatime):
	set_pos(camera.get_pos() + camera_offset)
	
func lerp_opacity(deltatime):
	fade_time_elapsed += deltatime
	if fade_time_elapsed < fade_time:
		set_opacity(lerp(start_opacity, target_opacity, fade_time_elapsed / fade_time))
	else:
		set_opacity(target_opacity)
		
func show():
	fade_time_elapsed = 0.0
	start_opacity = 0.0
	target_opacity = 1.0
	
func hide():
	fade_time_elapsed = 0.0
	start_opacity = 1.0
	target_opacity = 0.0

func is_hidden():
	return get_opacity() < 0.9
	
func check_input(deltatime):
	if is_hidden():
		return
	if button.is_pressed():
		hide()
		monk.stop_thinking()