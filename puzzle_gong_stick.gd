
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var sprite = null
var camera = null
var button = null
var gong = null
var gong_distance = 200

var monk = null

var moving = false
var move_offset = null

var start_pos = null

func _ready():
	start_pos = get_pos()
	sprite = get_node("sprite")
	camera = get_node("/root/camera")
	button = get_node("button")
	gong = get_node("../gong")
	
	monk = get_node("../../../monk")
	
	set_process(true)

func _process(deltatime):
	move_stick(deltatime)
	check_input(deltatime)

func move_stick(deltatime):
	if not moving:
		set_pos(lerp2d(get_pos(), start_pos, 2 * deltatime))
		return
	if camera == null:
		var mouse_pos = get_viewport().get_mouse_pos()
		set_pos(mouse_pos + move_offset)
	
func lerp2d(va, vb, weight):
	return Vector2(lerp(va.x, vb.x, weight), lerp(va.y, vb.y, weight))

func check_input(deltatime):
	if button.is_pressed():
		start_moving()
	else:
		stop_moving()

func start_moving():
	moving = true
	if camera == null:
		var mouse_pos = get_viewport().get_mouse_pos()
		move_offset = get_pos() - mouse_pos
	
	
func stop_moving():
	if not moving:
		return
	moving = false
	if get_pos().distance_to(gong.get_pos()) < gong_distance:
		gong()
		
func gong():
	monk.stop_thinking()
	get_node("../..").remove_child(get_node(".."))
	#gong.hide()
	# hide()