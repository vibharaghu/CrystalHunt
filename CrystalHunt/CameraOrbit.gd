extends Spatial


# Declare member variables here. Examples:
var lookSensitivity : float = 15.0
var minLookAngle : float = -20.0
var maxLookAngle : float = 75.0

var mouseDelta = Vector2()

onready var player = get_parent()

# called when an input is detected
func _input(event):
	if event is InputEventMouseMotion:
		mouseDelta = event.relative 
		#The mouse position relative to the previous position (position at the last frame).

# called every frame
func _process(delta):
	# get the rotation to apply to the camera and player
	var rot = Vector3(mouseDelta.y, mouseDelta.x, 0) * lookSensitivity * delta
	# camera vertical rotation
	rotation_degrees.x += rot.x
	rotation_degrees.x = clamp(rotation_degrees.x, minLookAngle, maxLookAngle)
	#clamp returns min or max if val is below or above the extremes. Returns the value otherwise
	
	# player horizontal rotation
	player.rotation_degrees.y -= rot.y
	
	# clear the mouse movement vector
	mouseDelta = Vector2()

# called when the node is initialized
func _ready ():
	# hide the mouse cursor
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
