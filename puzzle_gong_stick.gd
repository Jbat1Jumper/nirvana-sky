
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var sprite = null
var camera = null
var button = null
var gong = null
var gong_distance = 230

var puzzle_container = null

var moving = false
var move_offset = null

var start_pos = null

func _ready():
	start_pos = get_pos()
	sprite = get_node("sprite")
	camera = get_node("/root/scene/camera")
	button = get_node("button")
	gong = get_node("../gong")
	
	puzzle_container = get_node("../..")
	
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
		var last_pos = get_pos()
		move_offset = move_offset * 8 * deltatime
		set_pos(mouse_pos + move_offset)
		set_rot(lerp(get_rot(), (get_pos() - last_pos).angle(), 1 * deltatime))
	
func lerp2d(va, vb, weight):
	return Vector2(lerp(va.x, vb.x, weight), lerp(va.y, vb.y, weight))

func check_input(deltatime):
	if button.is_pressed():
		start_moving()
	else:
		stop_moving()

func start_moving():
	if get_node("../anim").is_playing():
		return
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
	else:
		miss_gong()
		
func done():
	puzzle_container.success()
	
func fail():
	puzzle_container.fail()
		
func gong():
	get_node("../anim/").play("hit_gong")
	
func miss_gong():
	get_node("../anim/").play("miss_gong")

func fail_sound():
	get_parent().play_sound("Broken_Sitar")
	
func success_sound():
	if randi() % 100 > 50:
		get_parent().play_sound("Gong_1")
	else:
		get_parent().play_sound("Gong_2")
