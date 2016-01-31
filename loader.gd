
extends Node

# member variables here, example:
# var a=2
# var b="textvar"
var player = null

func _ready():
	goto("menu")
	player = get_node("player")
	player.play("ggj2016maintheme")
	
	set_process(true)
	
func _process(delta):
	if not player.is_active():
		player.play("ggj2016maintheme_loop")
	for child in get_children():
		if child.get_name() == "todelete":
			remove_child(child)
	
func goto(name):
	var scene_file = "res://" + name + ".scn"
	print("toggle_scene " + scene_file)
	var scene = load(scene_file).instance()
	scene.set_name("scene")
	var old_scene = get_node("scene")
	if old_scene != null:
		old_scene.set_name("todelete")
	add_child(scene)