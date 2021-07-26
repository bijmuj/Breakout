extends Area2D


onready var sprite = $Sprite

func _physics_process(_delta):
	var x = get_global_mouse_position().x
	global_position.x = x

func _on_Player_body_entered(body):
	var dir = Vector2(0, -1)
	dir.x = (body.global_position - global_position).x / 40
	body.bounce(dir)
