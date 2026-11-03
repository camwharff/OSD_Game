extends Node

var phases = ["Dawn", "Morning", "Afternoon"]
var current_phase = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.setup()

func _on_hud_advance_phase():
	get_node(phases[current_phase]).hide()
	current_phase += 1
	print("advancing phase to ", phases[current_phase])
	var new_phase = get_node(phases[current_phase])
	new_phase.show()
	GameState.start_phase(new_phase)
	
	# Debug
	print("tasks that should be visible:")
	for task in GameState.tasks.values():
		if task.enable and task.in_phase and not task.complete:
			print("	", task.task_name)

func _begin_game():
	print("begin game")
	GameState.start_phase(get_node(phases[0]))
