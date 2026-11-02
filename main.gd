extends Node

var phases = ["Dawn", "Morning", "Afternoon"]
var current_phase = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.setup()

func _on_hud_advance_phase():
	get_node(phases[current_phase]).visible = false
	current_phase += 1
	print("advancing phase to ", phases[current_phase])
	var new_phase = get_node(phases[current_phase])
	new_phase.visible = true
	GameState.start_phase(new_phase)

func _begin_game():
	print("begin game")
	GameState.start_phase(get_node(phases[0]))
