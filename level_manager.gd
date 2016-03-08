extends Node2D

var monk
var puzzle_container
var file

func _ready():
	set_process(true)
	monk = get_node("../monk")
	puzzle_container = get_node("../puzzle_container")
	file = File.new()
	file.open("res://level.txt", File.READ)

var to_next_row = 0
var last_h = 0

func _process(delta):
	var monk_h = monk.max_height()
	if monk_h > last_h:
		to_next_row -= monk_h - last_h
		last_h = monk_h
	
	while to_next_row <= 0:
		get_next_row()
		
func get_next_row():
	if not file.is_open():
		print("level file is closed")
		to_next_row += 100
		return
		
	var a = file.get_csv_line()
	if a == null or file.eof_reached():
		print("level finished")
		file.close()
		to_next_row += 100
		return
	
	process_row(a)
	
func process_row(a):
	print(a)
	to_next_row += int(a[0].strip_edges())
	var action = a[1].strip_edges()
	var a2 = []
	for n in range(2, a.size()):
		a2.append(a[n].strip_edges())
	call("action_" + action, a2)
	
func action_chakra(a):
	print("changing chakra")
	get_node("../chakra").change_chakra()
	
func action_puzzles(a):
	print("changing puzzles to " + str(a))
	if a.size() % 3 != 0:
		print("action_puzzles % 3 != 0")
		return
	
	var r = []
	for n in range(0, a.size() / 3):
		var m = n*3
		r.append([
			[
				a[m],
				int(a[m+1])
			],
			int(a[m+2])
		]);
		
	puzzle_container.puzzles = r
	
func action_print(a):
	for l in a:
		print(l)
	
func action_gravity(a):
	print("changing gravity to " + a[0])
	monk.gravity = float(a[0])
	
func action_window(a):
	print("changing fall window to " + a[0])
	monk.fall_max = int(a[0])
	
func action_penality(a):
	print("changing fall penality to " + a[0])
	monk.fall_penality = int(a[0])
	
func action_falltime(a):
	print("changing fall time to " + a[0])
	monk.fall_time = float(a[0])
	
func action_nirvana(a):
	print("nirvana!")
	monk.must_nirvana = true
	
	