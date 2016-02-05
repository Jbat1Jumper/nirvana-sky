extends Node2D

var sprite = null
var camera = null
var button = null
var started = false
var start_pos = null

func _ready():
	start_pos = get_pos()
	sprite = get_node("sprite")
	camera = get_node("/root/scene/camera")
	button = get_node("Button")
	bar = get_node("../bar")
	set_process(true)

func _process(deltatime):
	check_input(deltatime)

func check_input(deltatime):
	if button.is_pressed():
		started = true
		bar.increaseLevel(deltatime)
	else:
		if started == true :
			bar.checkWinCondition()
