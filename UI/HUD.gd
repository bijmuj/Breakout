extends CanvasLayer

onready var score = $Score
onready var message = $Message
onready var timer = $Timer
onready var start_button = $StartButton
signal start_game

func show_message(text):
	message.text = text
	message.show()
	timer.start(3)


func show_game_over(text):
	show_message(text)
	yield(timer, "timeout")
	message.text = "Breakout"
	message.show()
	start_button.show()


func update_score(val):
	score.text = "Score: " + str(val)


func _on_StartButton_pressed():
	start_button.hide()
	show_message("Get Ready")
	yield(timer, "timeout")
	emit_signal("start_game")


func _on_Timer_timeout():
	message.hide()
