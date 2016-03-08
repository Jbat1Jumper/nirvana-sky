
extends Node2D

var camera
var monk

func _ready():
	set_process(true)
	camera = get_node("../camera")
	monk = get_node("../monk")

func _process(delta):
	set_pos(camera.get_pos())

var must_change = false
var current = 0
var boost = 100

func change_chakra():
	must_change = true

func check_change_chakra():
	if must_change and monk.success_doing_puzzles:
		must_change = false
		_change_chakra()

func _change_chakra():
	monk.speed -= boost
	get_node("sprite").set_modulate(Color(randf(), randf(), randf()))
	current += 1
