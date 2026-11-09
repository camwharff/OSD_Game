extends Area2D

signal new_game
signal hover_start(enable: bool)

@onready var sprite: Sprite2D = $Sprite2D

var color_accessible


func _ready() -> void:
	add_to_group("clickables")
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func _on_mouse_entered() -> void:
	if color_accessible:
		sprite.modulate = Color("00aaffff")
	else:
		sprite.modulate = Color(1.3, 1.3, 1.3)
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	hover_start.emit(true)


func _on_mouse_exited() -> void:
	if color_accessible:
		sprite.modulate = Color("00fff2ff")
	else:
		sprite.modulate = Color(1, 1, 1)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	hover_start.emit(false)


func _on_input_event(_viewport, event, _shape_idx) -> void:
	if event.is_action_pressed("leftclick"):
		new_game.emit()


func enable_accessible_colors(enable: bool):
	if enable:
		sprite.modulate = Color("00fff2ff")
		color_accessible = true
	else:
		sprite.modulate = Color(1, 1, 1)
		color_accessible = false
