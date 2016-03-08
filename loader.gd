
extends Node

# member variables here, example:
# var a=2
# var b="textvar"
var player = null
var music = null

func _ready():
	print("hi")
	music = get_node("/root/loader/music")
	goto("menu")
	
func _process(delta):
	for child in get_children():
		if child.get_name() == "todelete":
			remove_child(child)
			set_process(false)
	
func goto(name):
	var scene_file = "res://" + name + ".scn"
	print("toggle_scene " + scene_file)
	var scene = load(scene_file).instance()
	scene.set_name("scene")
	var old_scene = get_node("scene")
	if old_scene != null:
		old_scene.set_name("todelete")
		set_process(true)
	add_child(scene)
	
