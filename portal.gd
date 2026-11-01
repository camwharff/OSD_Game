extends Area2D

signal update_scene(dest: String)
signal hover(message: String, enable: bool)

@export var destination: String
@export var hover_message: String

@onready var sprite: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("portals")
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered() -> void:
	sprite.modulate = Color(1.3, 1.3, 1.3) # brighten sprite
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	hover.emit(hover_message, true)

func _on_mouse_exited() -> void:
	sprite.modulate = Color(1, 1, 1) # dim sprite
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	hover.emit(hover_message, false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Called when a portal is clicked. Changes the scene to the destination.
func _on_input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("leftclick"):
		update_scene.emit(destination)
