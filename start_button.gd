extends Area2D

signal phases_start
signal hover_start(enable: bool)

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered() -> void:
	sprite.modulate = Color(1.3, 1.3, 1.3) # brighten sprite
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	hover_start.emit(true)

func _on_mouse_exited() -> void:
	sprite.modulate = Color(1, 1, 1) # dim sprite
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	hover_start.emit(false)

func _on_input_event(_viewport, event, _shape_idx) -> void:
	if event.is_action_pressed("leftclick"):
		phases_start.emit()
