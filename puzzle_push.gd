extends Node2D

var camera = null
var puzzle_container = null
var start_pos = null
var level = 0 
var levelIncrement = 0
var limit = 0
var limitVar = 0
var difficulty = 0
var bar = null
var barTop = 0
var pushButton = null
var puzzleStarted


func play_sound(s):
	var player = get_node("/root/loader/player")
	if player != null:
		player.play(s)


func _ready():
	bar = get_node("bar")
	start_pos = bar.get_node("level").get_pos()
	limit = bar.get_node("limit").get_pos().y
	barTop = bar.get_node("top").get_pos().y
	pushButton = get_node("push_button")
	camera = get_node("/root/scene/camera")
	puzzle_container = get_parent()
	puzzleStarted = false
	
	if difficulty < 1:
		limitVar = 200
		levelIncrement = 100
	if difficulty == 1:
		limitVar = 100
		levelIncrement = 150
	if difficulty > 1:
		limitVar = 50
		levelIncrement = 200
	get_node("bar/limitVar").set_pos(bar.get_node("limit").get_pos())
	get_node("bar/limitVar").set_scale(Vector2(1,limitVar))
	set_process(true)

func _process(deltatime):
	if pushButton.get_node("Button").is_pressed():
		increaseLevel(deltatime)
		puzzleStarted = true
	else:
		if puzzleStarted:
			checkWinCondition()
	

func lerp2d(va, vb, weight):
	return Vector2(lerp(va.x, vb.x, weight), lerp(va.y, vb.y, weight))

func increaseLevel(deltatime):
	level = level + levelIncrement * deltatime
	bar.get_node("level").set_pos(start_pos+Vector2(0,-level))
	if level >= -barTop:
		fail_top()	

func checkWinCondition():
	if (level <= (-limit)+limitVar) and (level >= (-limit)-limitVar):
		success()
	else:
		fail_outside_limit()

func fail_top():
	fail()
	pass

func fail_outside_limit():
	fail()
	pass

func fail():
	puzzle_container.fail()
	
func success():
	puzzle_container.success()
