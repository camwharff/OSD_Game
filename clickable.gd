class_name Clickable
extends Area2D

signal hover(message: String, enable: bool)

@export var task_name: String = "Task"
@export var time_cost: int = 1
@export var tidiness_change: int = 0
@export var energy_change: int = 0
@export var satisfaction_change: int = 0
@export var performance_change: int = 0
@export var carryover_change: int = 0
@export var early_exit: bool = false
@export var hover_message: String
@export var begin: int = 0
@export var end: int = 100

var enable = false
var complete = false
var is_done = false
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	add_to_group("tasks")
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	if begin == 0:
		enable = true
	for task in get_tree().get_nodes_in_group("tasks"):
		if task.enable == false:
			task.sprite.hide()
			task.input_pickable = false

func _on_mouse_entered() -> void:
	sprite.modulate = Color(1.3, 1.3, 1.3) # brighten sprite
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	hover.emit(hover_message, true)

func _on_mouse_exited() -> void:
	sprite.modulate = Color(1, 1, 1) # dim sprite
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	hover.emit(hover_message, false)

func _on_input_event(_viewport, event, _shape_idx) -> void:
	if event.is_action_pressed("leftclick"):
		sprite.visible = false
		GameState.apply_task(self)
		input_pickable = false

func complete_task() -> void: 
	for task in get_tree().get_nodes_in_group("tasks"):
		if task.enable == false || task.complete == true:
			task.sprite.hide()
			task.input_pickable = false
		else:
			task.sprite.show()
			task.input_pickable = true
	is_done = true
