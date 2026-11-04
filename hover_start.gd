extends Node2D

func _on_start_button_hover_start(enable):
	if enable:
		show()
	else:
		hide()
