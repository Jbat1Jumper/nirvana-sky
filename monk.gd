
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

var gravity = 10.0
var start_y = 0

func _ready():
	start_y = get_pos().y
	set_process(true)
	
func _process(deltatime):
	