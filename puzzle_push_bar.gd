extends Node2D

var start_pos = null
var level = 0 
var levelIncrement = 10
var barTop = 100
var lowerLimit = 50
var upperLimit = 70

func _ready():
	start_pos = get_pos()
	sprite = get_node("sprite")
	camera = get_node("/root/scene/camera")
	set_process(true)

func _process(deltatime):

func lerp2d(va, vb, weight):
	return Vector2(lerp(va.x, vb.x, weight), lerp(va.y, vb.y, weight))

func increaseLevel(deltatime):
	level = level + levelIncrement * deltatime
	if level >= barTop:
		fail()	

func checkWinCondition():
	if level >= lowerLimit and level <= upperLimit:
		success()
	else:
		fail()
	
func success():
	done()

func fail():
	done()

func done():
	get_node("../..").remove_child(get_node(".."))