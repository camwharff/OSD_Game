class_name Clickable
extends Area2D

signal task_requested(task: Clickable)

@export var task_name: String = "Task"
@export var time_cost: int = 1
@export var tidiness_change: int = 0
@export var energy_change: int = 0
@export var satisfaction_change: int = 0
@export var performance_change: int = 0
@export var carryover_change: int = 0
@export var alert_texture: Texture2D
@export var normal_texture: Texture2D

var is_done = false
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
		sprite.texture = alert_texture

func _on_input_event(_viewport, event, _shape_idx) -> void:
	if is_done:
		sprite.texture = normal_texture
	if event.is_action_pressed("leftclick"):
		task_requested.emit(self)

func complete() -> void: 
	is_done = true
	sprite.texture = normal_texture
	GameState.apply_task(self)
