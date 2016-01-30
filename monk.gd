
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

var gravity = 10.0
var speed = 0.0
var max_speed = 40.0
var start_y = 0.0

func _ready():
	start_y = get_pos().y
	set_process(true)
	
func _process(deltatime):
	check_input(deltatime)
	calculate_physics(deltatime)
	
func check_input(deltatime):
	pass	

func calculate_physics(deltatime):
	var pos = get_pos()
	
	speed += gravity * deltatime
	if abs(speed) > max_speed:
		speed = max_speed * sign(speed)
	set_pos(Vector2(pos.x, pos.y + speed * deltatime))
	
	pos = get_pos()
	if pos.y > start_y:
		speed = 0.0
		set_pos(Vector2(pos.x, start_y))

	