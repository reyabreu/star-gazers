extends CanvasLayer

signal start_simulation 

onready var message_label = $MessageLabel
onready var message_timer = $MessageTimer
onready var start_button = $StartButton 

func show_message(text):
	message_label.text = text
	message_label.show()
	message_timer.start()

func show_simulation_end():
	show_message("Simulation has ended")
	yield(message_timer, "timeout")
	message_label.text = "Star Gazers"
	message_label.show()
	start_button.show()

func _on_MessageTimer_timeout():
	message_label.hide()

func _on_StartButton_pressed():
	start_button.hide()
	emit_signal("start_simulation")