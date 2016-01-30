extends Node2D

var stick = null
var positions = null

func _ready():
	stick = get_node("stick")
	seed(OS.get_unix_time())
	var n = randi() % get_node("positions").get_child_count()
	stick.start_pos = get_node("positions/" + str(n)).get_pos()
	stick.set_pos(stick.start_pos)
	
	

