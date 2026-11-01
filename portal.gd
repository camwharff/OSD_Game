extends Area2D

signal update_scene(dest: String)

@export var destination: String

@onready var sprite: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("portals")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Called when a portal is clicked. Changes the scene to the destination.
func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("leftclick"):
		update_scene.emit(destination)
