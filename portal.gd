extends Area2D

signal change_scene(dest: String)

@export var destination: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Called when a portal is clicked. Changes the scene to the destination.
func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("leftclick"):
		change_scene.emit(destination)
