extends Label

var time = 0
onready var end = get_node('../Retry')

func _process(delta):
	time -= delta
	
	#if time <= 0:
		#time = 0
		#end.show()
		#if Input.is_action_pressed("ui_accept"):
			#end.hide()
			#time = 10
			
	var sec = fmod(time, 60)
	var minutes = fmod(time, 60 * 60) /60

	var time_left = "Time: %02d : %02d" % [minutes, sec]
	text = time_left
	

