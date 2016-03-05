extends Node2D

var stick = null
var positions = null
var difficulty = 0
var puzzle_container

func _ready():
	puzzle_container =  get_node("..")
	stick = get_node("stick")
	seed(OS.get_unix_time())
	var n = randi() % get_node("positions").get_child_count()
	stick.start_pos = get_node("positions/" + str(n)).get_pos()
	stick.set_pos(stick.start_pos)

func play_sound(s):
	var player = get_node("/root/loader/player")
	if player != null:
		player.play(s)
