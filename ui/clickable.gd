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
@export var repeatable: bool = false
@export var ending_flag: bool = false
@export var prereqs: Array[String] = []
@export var blocked_by: Array[String] = []
@export var phases: Array[String] = []

var enable = false
var complete = false
var is_done = false
var in_phase = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	add_to_group("tasks")
	
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

func _on_input_event(_viewport, event, _shape_idx) -> void:
	if event.is_action_pressed("leftclick"):
		GameState.apply_task(self)
		input_pickable = false
		hover.emit("plonk", false)
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		audio.play()

func complete_task() -> void: 
	is_done = true
	complete = true
