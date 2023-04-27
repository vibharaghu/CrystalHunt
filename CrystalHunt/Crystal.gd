extends Area


export var pointsToGive : int = 1

func _on_Crystal_body_entered(body):
	if body.name == "Player3":
		body.give_points(pointsToGive)
		queue_free()

func delete():
	queue_free()
