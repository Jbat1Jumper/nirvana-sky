
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var sprite = null
var camera = null
var button = null
var destino = null
var radio_limpieza = 230

var puzzle_container = null

var moving = false
var move_offset = null
var done = false


func _ready():
	sprite = get_node("sprite")
	camera = get_node("/root/scene/camera")
	button = get_node("button")
	
	puzzle_container = get_node("../../..")
	
	set_process(true)

func _process(deltatime):
	if not done:
		move_stick(deltatime)
		check_input(deltatime)

func move_stick(deltatime):
	if not moving:
		var c = 2
		set_rot(lerp(get_rot(), 0, c * deltatime)) 
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
		clean_dirt()
	if (not button.is_pressed() and moving == true):
		miss_gong()

func start_moving():
	# if get_node("../anim").is_playing():
	# 	return
	moving = true
	if camera == null:
		var mouse_pos = get_viewport().get_mouse_pos()
		move_offset = get_pos() - mouse_pos
	
	
func clean_dirt():
	radio_limpieza = button.get_size().length() / 2
	for n in range(1, 4):
		var d = get_node("../fondo/dirt" + str(n))
		if get_pos().distance_to(d.get_pos()) < radio_limpieza:
			d.dirt_cleaned = true;
			d.set_opacity(0.0)
			if all_dirt():
				gong()
		
func all_dirt():
	var all = true
	for n in range(1, 4):
		var p = get_node("../fondo/dirt" + str(n))
		if p and not p.dirt_cleaned:
			all = false
	return all
		
func done():
	puzzle_container.success()
	
func fail():
	puzzle_container.fail()
		
func gong():
	get_node("../fondo/subfondo/anim").play("success")
	print("Yeah")
	done = true
	pass
	
func miss_gong():
	get_node("../fondo/subfondo/anim").play("fail")
	print("Ugggggg")
	done = true
	pass
	
func fail_sound():
	get_parent().play_sound("Broken_Sitar")
	
func success_sound():
	if randi() % 100 > 50:
		get_parent().play_sound("Gong_1")
	else:
		get_parent().play_sound("Gong_2")