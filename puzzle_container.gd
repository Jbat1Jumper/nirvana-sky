
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var camera_offset = null
var camera = null

func _ready():
	set_process(true)
	
func _process(deltatime):
	move_camera(deltatime)

func move_camera(deltatime):
	pass
	#var camera_pos = get_pos() + camera_offset 
	#camera.set_pos(lerp2d(camera.get_pos(), camera_pos, camera_lerp_weight * deltatime))
	
#func lerp2d(va, vb, weight):
	#return Vector2(lerp(va.x, vb.x, weight), lerp(va.y, vb.y, weight))
	
