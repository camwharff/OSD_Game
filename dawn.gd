extends Node

var active: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	for portal in get_tree().get_nodes_in_group("portals"):
		portal.update_scene.connect(_on_update_scene)
	
	active = $Apartment
	GameState.start_phase(9)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_update_scene(destination: String) -> void:
	print("Changing scene to ", destination)
	active.visible = false
	active = get_node(destination)
	active.visible = true
