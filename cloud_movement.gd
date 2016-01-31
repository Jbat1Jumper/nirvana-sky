var start_position = get_pos()
export var direction = Vector2(1,0)

func _ready():
	set_process(true)

func _process(deltatime):
	if get_pos().x < 2000:
		set_pos(get_pos()+direction*deltatime)
	else:
		set_pos(start_position)