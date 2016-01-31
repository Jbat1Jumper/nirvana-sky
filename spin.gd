
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

export var speed = 10.0

func _ready():
	set_process(true)
	
func _process(delta):
	set_rot(get_rot() - speed * delta * 0.1)


