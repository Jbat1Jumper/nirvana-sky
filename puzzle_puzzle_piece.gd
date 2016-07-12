
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var sprite = null
var camera = null
var button = null
var destino = null
var distancia_destino = 230
var pieza_ok = false

var puzzle_container = null

var moving = false
var move_offset = null

var start_pos = null

func _ready():
	start_pos = get_pos()
	sprite = get_node("sprite")
	camera = get_node("/root/scene/camera")
	button = get_node("button")
	destino = get_node("../fondo/" + get_name())
	
	puzzle_container = get_node("../../..")
	
	set_process(true)

func _process(deltatime):
	move_stick(deltatime)
	check_input(deltatime)

func move_stick(deltatime):
	if not moving:
		var c = 2
		if pieza_ok:
			c = 5
		set_pos(lerp2d(get_pos(), start_pos, c * deltatime))
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
	else:
		stop_moving()

func start_moving():
	# if get_node("../anim").is_playing():
	# 	return
	moving = true
	if camera == null:
		var mouse_pos = get_viewport().get_mouse_pos()
		move_offset = get_pos() - mouse_pos
	
	
func stop_moving():
	if not moving:
		return
	moving = false
	distancia_destino = button.get_size().length() / 2
	if get_pos().distance_to(destino.get_pos()) < distancia_destino:
		if all_pieces():
			gong()
		start_pos = destino.get_pos()
	else:
		miss_gong()
		
func all_pieces():
	self.pieza_ok = true
	var all = true
	for n in range(1, 4):
		var p = get_node("../pieza" + str(n))
		if p and not p.pieza_ok:
			all = false
	return all
		
func done():
	puzzle_container.success()
	
func fail():
	puzzle_container.fail()
		
func gong():
	for n in range(1, 4):
		var pa = get_node("../pieza" + str(n) + "/anim")
		if pa:
			pa.play("success")
	get_node("../fondo/subfondo/anim").play("success")
	print("Yeah")
	pass
	
func miss_gong():
	for n in range(1, 4):
		var pa = get_node("../pieza" + str(n) + "/anim")
		if pa:
			pa.play("fail")
	get_node("../fondo/subfondo/anim").play("fail")
	print("Ugggggg")
	pass
	
func fail_sound():
	get_parent().play_sound("Broken_Sitar")
	
func success_sound():
	if randi() % 100 > 50:
		get_parent().play_sound("Gong_1")
	else:
		get_parent().play_sound("Gong_2")