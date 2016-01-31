
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var monk = null
var monk_offset = null
var camera_lerp_weight = 2

var target_opacity = 0.0
var start_opacity = 0.0
var fade_time_elapsed = 0.0
var fade_time = 0.5  # seg

func _ready():
	monk = get_node("../monk")
	monk_offset = get_pos() - monk.get_pos()
	set_process(true)
	
func _process(deltatime):
	align_with_monk(deltatime)
	lerp_opacity(deltatime)

func align_with_monk(deltatime):
	set_pos(lerp2d(get_pos(), monk.get_pos() + monk_offset, camera_lerp_weight * deltatime))
	
func lerp2d(va, vb, weight):
	return Vector2(lerp(va.x, vb.x, weight), lerp(va.y, vb.y, weight))
	
func lerp_opacity(deltatime):
	fade_time_elapsed += deltatime
	if fade_time_elapsed < fade_time:
		set_opacity(lerp(start_opacity, target_opacity, fade_time_elapsed / fade_time))
	else:
		set_opacity(target_opacity)	

func turn_on():
	if get_opacity() == 1.0:
		return
	fade_time_elapsed = 0.0
	fade_time = 0.5
	start_opacity = 0.0
	target_opacity = 1.0
	
func turn_off():
	if get_opacity() == 0.0:
		return
	fade_time_elapsed = 0.0
	fade_time = 0.2
	start_opacity = 1.0
	target_opacity = 0.0
	
	
func is_hidden():
	return get_opacity() < 0.9