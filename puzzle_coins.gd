
extends Node2D

var camera = null
var coins_offset = null
var amount = 0
var sequence = []
var monk = null
var difficulty = 0

func _ready():
	#seed(OS.get_unix_time())
	camera = get_node("/root/scene/camera")
	monk = get_node("../../monk")
	coins_offset = get_pos() - get_node("coins").get_pos()
	set_process(true)
	create()

func create():
	
	var max_amount = 3
	if difficulty > 4:
		max_amount = 5
	elif difficulty > 2:
		max_amount = 4
	
	var px = []
	var py = []
	for point in get_node("positions").get_children():
		var pos = point.get_pos()
		if px.size() != 0:
			var where = randi() % px.size() 
			px.insert(where, pos.x)
			py.insert(where, pos.y)
		else:
			px.append(pos.x)
			py.append(pos.y)
	
	amount = 3 + randi() % (max_amount - 3)
	
	var style = randi() % 2
	
	var i = 0
	for coin in get_node("coins").get_children():
		if int(coin.get_name()) >= amount:
			get_node("coins").remove_child(coin)
		else:
			coin.get_node("sprite").set_frame(style)
			coin.set_pos(Vector2(px[i], py[i]) + coins_offset)
			i += 1
			
func _process(delta):
	if Input.is_key_pressed(KEY_R):
		create(5)
	
	if get_node("anim").is_playing():
		return
	for coin in get_node("coins").get_children():
		if coin.get_node("button").is_pressed():
			var cname = int(coin.get_name())
			if sequence.size() == 0:
				if cname != 0 and cname != amount - 1:
					get_node("anim").play("fail")
					continue
			
			var sq = sequence.find(cname)
			if sq != -1:
				if cname != sequence[sequence.size() - 1]:
					get_node("anim").play("fail")
					continue
			else:
				if sequence.size() != 0:
					var last = sequence[sequence.size()-1]
					if cname != last-1 and cname != last+1:
						get_node("anim").play("fail")
						continue
				
				coin.get_node("anim").play("glow")
				sequence.append(cname)
			if sequence.size() == amount:
				get_node("anim").play("success")
				
func fail():
	monk.fail_thinking()
	get_node("..").remove_child(self)
	
func success():
	monk.success_thinking()
	get_node("..").remove_child(self)
