var start_position = get_pos()
export var direction = Vector2(1,0)

func _ready():
	set_process(true)

func _process(deltatime):
	set_pos(get_pos()+direction*deltatime)