
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var monk = null
var monk_offset = null
var camera_lerp_weight = 2

var target_opacity = 0.0
var start_opacity = 0.0
var fade_time_elapsed = 0.0
var fade_time = 0.5  # seg

func _ready():
	monk = get_node("../monk")
	monk_offset = get_pos() - monk.get_pos()
	set_process(true)
	
func _process(deltatime):
	align_with_monk(deltatime)
	lerp_opacity(deltatime)
	#remove_puzzle()

#func remove_puzzle():
#	if target_opacity == 0.0 and get_node("puzzle") != null:

func align_with_monk(deltatime):
	set_pos(lerp2d(get_pos(), monk.get_pos() + monk_offset, camera_lerp_weight * deltatime))
	
func lerp2d(va, vb, weight):
	return Vector2(lerp(va.x, vb.x, weight), lerp(va.y, vb.y, weight))
	
func lerp_opacity(deltatime):
	fade_time_elapsed += deltatime
	if fade_time_elapsed < fade_time:
		set_opacity(lerp(start_opacity, target_opacity, fade_time_elapsed / fade_time))
	else:
		set_opacity(target_opacity)

func _turn_on():
	if get_opacity() == 1.0:
		return
	fade_time_elapsed = 0.0
	fade_time = 0.5
	start_opacity = 0.0
	target_opacity = 1.0
	
func _turn_off():
	if get_opacity() == 0.0:
		return
	fade_time_elapsed = 0.0
	fade_time = 0.2
	start_opacity = 1.0
	target_opacity = 0.0
	
var puzzles = [
	[["puzzle_gong", 5], 3],
	[["puzzle_coins", 5], 3],
	[["puzzle_push", 5], 8]
]
	
func _choose_puzzle():
	return _choose(puzzles)
	
	

func _choose(list):
	var t = 0
	for l in list:
		t += l[1]
	var r = randi() % t
	t = 0
	for l in list:
		if r >= t and r < (t + l[1]):
			return l[0]
		t += l[1]
	return null
	
func create_puzzle():
	var p = _choose_puzzle()
	var puzzle = scenes["puzzle_" + p[0]].instance()
	puzzle.set_name("puzzle")
	puzzle.difficulty = p[1]
	add_child(puzzle)
	_turn_on()
	
func success():
	_turn_off()
	monk.success_thinking()
	remove_child(get_node("puzzle"))
	
func fail():
	_turn_off()
	monk.fail_thinking()
	remove_child(get_node("puzzle"))
	
var scenes = {
	"puzzle_gong": load("res://puzzle_gong.scn"),
	"puzzle_coins": load("res://puzzle_coins.scn"),
	"puzzle_push": load("res://puzzle_push.scn"),
	"puzzle_tv": load("res://puzzle_tv.scn"),
	"puzzle_kiss": load("res://puzzle_kiss.scn"),
	"puzzle_puzzle": load("res://puzzle_puzzle.scn"),
	"puzzle_cleaning": load("res://puzzle_cleaning.scn")
}

func is_hidden():
	return get_opacity() < 0.9
