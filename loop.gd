
extends StreamPlayer

# member variables here, example:
# var a=2
# var b="textvar"

var threshold = 0.1

func _ready():
	set_process(true)
	
func _process(delta):
	if get_pos() > get_length() - threshold:
		seek_pos(0)
