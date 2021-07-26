extends RigidBody2D

export(int) var SCREEN_WIDTH = 800
export(int) var MAX_SPEED = 350 
var vel = Vector2.ZERO

signal lost

func _physics_process(_delta):
	if global_position.y > 600:
		emit_signal("lost")
		queue_free()
		
	elif global_position.y <= 0:
		bounce(Vector2(linear_velocity.x/MAX_SPEED, 1))
		
	elif global_position.x <= 0 or global_position.x >= SCREEN_WIDTH:
		bounce(Vector2(-linear_velocity.x, linear_velocity.y))

func bounce(dir):
	dir = dir.normalized() 
	linear_velocity = dir * MAX_SPEED
