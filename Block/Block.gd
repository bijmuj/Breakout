extends Area2D

signal broken

func bounce(body, vertical):
	var dir = body.linear_velocity
	if vertical:
		dir.x = -dir.x
	else:
		dir.y = -dir.y
	body.bounce(dir)
	emit_signal("broken")
	queue_free()


func _on_Block_body_entered(body):
	var dir = global_position - body.global_position
	if abs(dir.x) >= 39:
		bounce(body, true)
	else:
		bounce(body, false)
