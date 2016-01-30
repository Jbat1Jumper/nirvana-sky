
extends Sprite

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


var camera = null
var camera_offset = Vector2(0, 0)
var camera_lerp_weight = 0.1

func _ready():
	start_y = get_pos().y
	button = get_node("button")
	camera = get_node("../camera")
	camera_offset = get_pos() - camera.get_pos()
	set_process(true)
	
func _process(deltatime):
	check_input(deltatime)
	calculate_physics(deltatime)
	move_camera(deltatime)
	
func check_input(deltatime):
	if not button_was_pressed:
		if button.is_pressed():
			button_was_pressed = true
			if speed > 0:
				speed = 0
			speed -= 300
			print("Up!")
	else:
		if not button.is_pressed():
			button_was_pressed = false
			print("Release")
		

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
	var camera_pos = get_pos() - camera_offset 
	camera.set_pos(lerp2d(camera.get_pos(), camera_pos, camera_lerp_weight))
	
func lerp2d(va, vb, weight):
	return Vector2(lerp(va.x, vb.x, weight), lerp(va.y, vb.y, weight))