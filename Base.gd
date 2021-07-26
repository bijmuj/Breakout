extends Node2D

var ball
var player
var num_blocks = 0
var balls = 5
var score = 0

onready var Player = preload("res://Player/Player.tscn")
onready var Ball = preload("res://Ball/Ball.tscn")
onready var Block = preload("res://Block/Block.tscn")
onready var hud = $HUD

export(Vector2) var ball_start = Vector2(400, 300)
export(Vector2) var player_start = Vector2(400, 560)


func start_game():
	for i in range(10):
		for j in range(3):
			var block = Block.instance()
			block.position.y = j * 20 + 100
			block.position.x = i * 80 + 40
			block.connect("broken", self, "_on_block_broken")
			add_child(block)
			num_blocks += 1
			
	player = Player.instance()
	player.global_position = player_start
	add_child(player)
	spawn_ball()
	
	score = 0
	hud.update_score(score)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func end_game(text):
	for child in get_children():
		if child.name != "HUD":
			child.queue_free()

	hud.show_game_over(text)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func spawn_ball():
	ball = Ball.instance()
	ball.global_position = ball_start
	ball.linear_velocity = Vector2.DOWN * ball.MAX_SPEED
	ball.gravity_scale = 0
	ball.connect("lost", self, "_on_Ball_lost")
	add_child(ball)


func _on_Ball_lost():
	if balls == 0:
		end_game("Game Over!")
	else:
		balls -= 1
		update_score(-10)
		spawn_ball()


func _on_block_broken():
	update_score(10)
	
	num_blocks -= 1
	if num_blocks == 0:
		end_game("You Win!")


func update_score(val):
	score += val
	if score < 0:
		score = 0
	hud.update_score(score)
