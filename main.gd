extends Node

@onready var rooms = $Rooms
@onready var phases: Array = $Phases.get_children()
var current_phase = 0
const LAST_PHASE = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.setup()

func _begin_game():
	print("begin game")

func _start_first_phase():
	$Title.hide()
	$HUD.show()
	_start_phase()
	print("first phase started")

func _on_hud_advance_phase():
	current_phase += 1
	if current_phase >= phases.size():
		print("game over")  # end screen goes here
		return
	_start_phase()

func _start_phase():
	var phase: Phase = phases[current_phase]
	print("starting phase ", phase.phase_name)
	GameState.start_phase(phase)
	rooms.enable_phase_portals(phase.phase_name)
	rooms.go_to(phase.default_room)
