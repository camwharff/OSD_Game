extends Node

@onready var rooms = $Rooms
@onready var phases: Array = $Phases.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.setup()

func _start_first_phase():
	_play_click_audio()
	$Rooms.show()
	$Title.hide()
	$HUD.show()
	_start_phase()

func _on_hud_advance_phase():
	GameState.current_phase += 1
	if GameState.current_phase >= phases.size():
		$HUD.game_end()
	else:
		_start_phase()

func _start_phase():
	var phase: Phase = phases[GameState.current_phase]
	GameState.start_phase(phase)
	rooms.enable_phase_portals(phase.phase_name)
	rooms.go_to(phase.default_room)

func _on_new_game() -> void:
	GameState.new_game_setup()
	$Rooms.show()
	$HUD.start_new_game()
	_start_phase()

func _on_to_title() -> void:
	$HUD.hide()
	$Rooms.hide()
	$Title.show()

func _on_menu_open_credits() -> void:
	$HUD.open_credits()

func _play_click_audio():
	$ClickSound.play()
