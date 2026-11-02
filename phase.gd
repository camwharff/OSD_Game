extends Node2D

@export var phase_name: String
@export var default_room: Node2D
@export var time_limit: int = 0

var active: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	active = default_room
	
	# Connect the portals that are used in this phase
	for portal in get_tree().get_nodes_in_group("portals").filter(
		func(node): return node.is_in_group(phase_name)
	):
		portal.update_scene.connect(_on_update_scene)

func _on_update_scene(destination: String) -> void:
	active.visible = false
	active = get_node(destination)
	active.visible = true
