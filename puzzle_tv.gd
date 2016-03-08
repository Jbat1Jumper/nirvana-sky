extends Node2D

var camera = null
var puzzle_container = null
var difficulty = 0
var puzzleStarted


func play_sound(s):
	var player = get_node("/root/loader/player")
	if player != null:
		player.play(s)


func _ready():
	
	camera = get_node("/root/scene/camera")
	puzzle_container = get_parent()
	puzzleStarted = false
	
	if difficulty < 1:
		pass
	get_node("tv/AnimationPlayer").play("puzzle_tv")
	
	set_process(true)

func _process(deltatime):
	if get_node("remote/Button").is_pressed():
		explode()
	pass

func lerp2d(va, vb, weight):
	return Vector2(lerp(va.x, vb.x, weight), lerp(va.y, vb.y, weight))


func checkWinCondition():
	pass

func brain_washed():
	set_process(false)
	get_node("tv/AnimationPlayer").play("puzzle_fail")

func explode():
	set_process(false)
	get_node("tv/AnimationPlayer").play("puzzle_success")


func fail():
	puzzle_container.fail()
	
func success():
	puzzle_container.success()
