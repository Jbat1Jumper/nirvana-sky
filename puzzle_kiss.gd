extends Node2D

var camera = null
var puzzle_container = null
var difficulty = 0
var puzzleStarted
var personA
var personB

func play_sound(s):
	var player = get_node("/root/loader/player")
	if player != null:
		player.play(s)


func _ready():
	get_node("fail").hide()
	get_node("succ").hide()
	personA = (randi() % 2)+1
	if personA == 1:
		get_node("personA/bored").show()
	if personA == 2:
		get_node("personA/shy").show()
	personB = (randi() % 2)+1
	if personB == 1:
		get_node("personB/bored").show()
	if personB == 2:
		get_node("personB/shy").show()
	camera = get_node("/root/scene/camera")
	puzzle_container = get_parent()
	puzzleStarted = false
	
	if difficulty < 1:
		pass
	
	set_process(true)

func _process(deltatime):
	if get_node("dont_kiss_butt/Button").is_pressed():
		set_process(false)
		dont_kiss()
	if get_node("kiss_butt/Button").is_pressed():
		set_process(false)
		try_kiss()

func lerp2d(va, vb, weight):
	return Vector2(lerp(va.x, vb.x, weight), lerp(va.y, vb.y, weight))


func try_kiss():
	react()
	print(personA)
	print(personB)
	print("========")
	if personA==4 and personB==4:
		get_node("AnimationPlayer").play("puzzle_kiss_success_love")
		return
	else:
		get_node("AnimationPlayer").play("puzzle_kiss_fail")
		return

func dont_kiss():
	react()
	if personA==4 and personB==4:
		get_node("AnimationPlayer").play("puzzle_kiss_fail")
		return
	else:
		get_node("AnimationPlayer").play("puzzle_kiss_success")
		return

func react():
	personA=personA+2
	if personA == 3:
		get_node("personA/bored").hide()
		get_node("personA/nope").show()
	if personA == 4:
		get_node("personA/shy").hide()
		get_node("personA/kissing").show()
	personB=personB+2
	if personB == 3:
		get_node("personB/bored").hide()
		get_node("personB/nope").show()
	if personB == 4:
		get_node("personB/shy").hide()
		get_node("personB/kissing").show()


func fail():
	puzzle_container.fail()
	
func success():
	puzzle_container.success()
