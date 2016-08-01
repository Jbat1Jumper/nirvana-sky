extends Node2D

var camera = null
var puzzle_container = null
var difficulty = 0
var puzzleStarted

func _ready():
	puzzle_container =  get_node("..")
	seed(OS.get_unix_time())

func play_sound(s):
	var player = get_node("/root/loader/player")
	if player != null:
		player.play(s)
