extends KinematicBody


export(NodePath) var animationtree
onready var _anim_tree = $AnimationTree
onready var ui = get_node("/root/MainScene/CanvasLayer/UI")
onready var end = false

var points : int = 0

# physics
var moveSpeed : float = 5.0
var sprint : bool = false
var jumpForce : float = 15.0
var gravity : float = 40.0
var moving : bool = false
var direction : float = 90
var vel = Vector3()
var input = Vector3()
# components
onready var camera = get_node("CameraOrbit")
onready var model = get_node("megan")

func _physics_process(delta):
		
	#reset x and z axis
	vel.x = 0
	vel.z = 0
	
	if is_on_floor():
		input = Vector3()
	
	moving = false
	# movement inputs
	if Input.is_action_pressed("sprint"):
		sprint = true
	else: 
		sprint = false
	if Input.is_action_pressed("move_forwards") and not end:
		input.z += 1
		model.set_rotation(Vector3(0,0, 0))
		moving = true
	if Input.is_action_pressed("move_backwards") and not end:
		input.z -= 1
		model.set_rotation(Vector3(0,PI, 0))
		moving = true
	if Input.is_action_pressed("move_left") and not end:
		input.x += 1
		model.set_rotation(Vector3(0,PI/2, 0))
		moving = true
	if Input.is_action_pressed("move_right") and not end:
		input.x -= 1
		model.set_rotation(Vector3(0,-PI/2, 0))
		moving = true
		
		
	# normalize the input vector to prevent increased diagonal speed
	input = input.normalized()
	
	# get the relative direction
	var dir = (transform.basis.z * input.z + transform.basis.x * input.x)
	
	if sprint and moving and not end:
		moveSpeed += 0.5
		if moveSpeed > 10.0:
			moveSpeed = 10.0
	elif end:
		moveSpeed = 0
	else:
		moveSpeed = 5.0 
	
	# apply the direction to our velocity
	vel.x = dir.x * moveSpeed
	vel.z = dir.z * moveSpeed
	
	# gravity
	vel.y -= gravity * delta
	
	# jump input
	#if Input.is_action_pressed("jump") and is_on_floor():
	#	vel.y = jumpForce
	#_anim_tree["parameters/playback"].travel("Slow Run")
	if is_on_floor()	:
		if sprint and moving and not end:
			_anim_tree["parameters/playback"].travel("Slow Run")
		elif not moving or end:
			_anim_tree["parameters/playback"].travel("Idle")
		elif not end:
			_anim_tree["parameters/playback"].travel("Walking")
	#else:
	#	if moving:
	#		_anim_tree["parameters/playback"].travel("RunningJump")
	#	else:
	#		_anim_tree["parameters/playback"].travel("RunningJump")
		
	
	vel = move_and_slide(vel, Vector3.UP)


func _ready ():
	ui.update_crystal_text(0)
	$CrystalNoise.autoplay = false
	
func give_points(amount):
	$CrystalNoise.play()
	points += amount
	print(points)
	ui.update_crystal_text(points)


