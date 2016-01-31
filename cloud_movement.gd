var start_position = get_pos()
var direction = Vector2(1,0)
var speed = 2

func _ready():
	set_process(true)

func _process(deltatime):
	set_pos(get_pos()+direction*speed*deltatime)