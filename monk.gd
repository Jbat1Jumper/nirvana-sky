
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var gravity = 150.0
var speed = 0.0
var max_speed = 600.0
var air_speed = 50.0
var start_y = 0.0
var button = null
var button_was_pressed = false

var player = null

var camera = null
var camera_offset = Vector2(0, 0)
var camera_lerp_weight = 3

var doing_puzzles = false
var doing_puzzles_opacity = 0.7

var tap_count = 5
var tap_limit = null

var face_expression_time = 1

var puzzle_gong = load("res://puzzle_gong.scn")
var puzzle_coins = load("res://puzzle_coins.scn")

func _ready():
	player = get_node("/root/loader/player")
	start_y = get_pos().y
	button = get_node("button")
	camera = get_node("../camera")
	camera_offset = camera.get_pos() - get_pos()
	set_process(true)
	
func _process(deltatime):
	check_input(deltatime)
	calculate_physics(deltatime)
	move_camera(deltatime)
	change_animations(deltatime)
	check_tap_limit(deltatime)
	check_face_expression(deltatime)
	check_halt_time(deltatime)
	
func check_halt_time(deltatime):
	if doing_puzzles and halt_time != null:
		if halt_time > 0:
			halt_time -= deltatime
		else:
			halt_time = null
			success_thinking()
			get_node("sprite").set_frame(0)
		
	
		
func check_face_expression(deltatime):
	if face_expression_time != null:
		face_expression_time -= deltatime
		if face_expression_time <= 0:
			get_node("sprite").set_frame(0)

func check_tap_limit(deltatime):
	if tap_limit != null and not doing_puzzles:
		tap_limit -= deltatime
		if tap_limit < 0:
			start_thinking()
		

func check_input(deltatime):
	if not button_was_pressed:
		if button.is_pressed():
			if not doing_puzzles:
				tap_count -= 1
				button_was_pressed = true
				if tap_count == 0:
					start_thinking()
				if speed > 0:
					speed = -300
				else:
					speed -= (exp(speed/100.0)*2.9+0.1)*100
	else:
		if not button.is_pressed():
			button_was_pressed = false
		

func calculate_physics(deltatime):
	var pos = get_pos()
	if abs(speed) < air_speed:
		speed += gravity * deltatime * 0.5
	else:
		speed += gravity * deltatime
	if abs(speed) > max_speed:
		speed = max_speed * sign(speed)
	pos = Vector2(pos.x, pos.y + speed * deltatime)
	if pos.y > start_y:
		speed = 0.0
		pos = Vector2(pos.x, start_y)
		
	set_pos(pos)

func move_camera(deltatime):
	var camera_pos = get_pos() + camera_offset 
	camera.set_pos(lerp2d(camera.get_pos(), camera_pos, camera_lerp_weight * deltatime))
	
func lerp2d(va, vb, weight):
	return Vector2(lerp(va.x, vb.x, weight), lerp(va.y, vb.y, weight))
	
func change_animations(deltatime):
	if doing_puzzles:
		set_opacity(doing_puzzles_opacity)
	else:
		set_opacity(1.0)
		
		
func start_thinking():
	generate_puzzle()
	
	get_node("../puzzle").turn_on()
	
func success_thinking():
	doing_puzzles = false
	
	tap_count = 2 + randi() % 4
	tap_limit = 1.0 + (randi() % 15)/10.0
	get_node("sprite").set_frame(1)
	face_expression_time = 1
	get_node("../puzzle").turn_off()
		

var halt_time = null

func fail_thinking():
	#success_thinking()
	face_expression_time = 2
	halt_time = 3
	get_node("sprite").set_frame(2)
	get_node("../puzzle").turn_off()
	if speed < 0:
		speed = speed / 2
	speed += 200

		
func generate_puzzle():
	var puzzle_scn = puzzle_coins
	if randi() % 100 >= 50:
		puzzle_scn = puzzle_gong
	var puzzle = puzzle_scn.instance()
	puzzle.difficulty = 5
	get_node("../puzzle").add_child(puzzle)
	doing_puzzles = true
	