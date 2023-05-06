extends Spatial

onready var timer = get_node("CanvasLayer/UI/Timer")

onready var crystals = []
var rng = RandomNumberGenerator.new()


func _ready():
	randomize()
	for i in range(200):
		add_trees()
	for i in range(40):
		add_crystal()
	add_border()

func _process(delta):
	if timer.time <= 0:
		timer.time = 0
		$Player3.end = true
		$CanvasLayer/UI/Retry.show()

func add_trees(xwidth=160, xpos=-80, yheight = 1, zwidth=160, zpos=-80):
	var num = rng.randi_range(0,1)
	var tree
	if num == 0:
		tree = load("res://Tree1.tscn")
	else:
		tree = load("res://Tree2.tscn")
	var instance = tree.instance()
	add_child(instance)
	var position = Vector3(randi() % xwidth + xpos, yheight, randi() % zwidth + zpos)
	instance.translation = position
	

func add_border():
	for i in range(40):
		add_trees(5, -100, 0, 200, -100)
		add_trees(5, 95, 0, 200, -100)
		add_trees(200, -100, 0, 5, 95)
		add_trees(200, -100, 0, 5, -100)
	
func add_crystal():
	var crystal = load("res://Crystal.tscn")
	var instance = crystal.instance()
	add_child(instance)
	var position = Vector3(randi() % 180 - 90, 1, randi() % 180 - 90)
	instance.translation = position
	crystals.append(instance)

	
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $CanvasLayer/UI/Retry.visible:
		$Player3.points = 0
		$Player3.end = false
		$CanvasLayer/UI/Timer.time = 60
		$CanvasLayer/UI/Retry.hide()
		$CanvasLayer/UI.update_crystal_text($Player3.points)
		for i in crystals:
			if is_instance_valid(i):
				i.delete()
		crystals = []
		for i in range(20):
			add_crystal()
		
