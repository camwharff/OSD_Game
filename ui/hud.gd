extends CanvasLayer

signal advance_phase
signal game_ready
signal new_game
signal go_to_title
signal click_sound

@onready var time_text = $Display/Scores/ScoreGrid/Time/Score
@onready var energy_text = $Display/Scores/ScoreGrid/Energy/Score
@onready var sat_text = $Display/Scores/ScoreGrid/Satisfaction/Score
@onready var perf_text = $Display/Scores/ScoreGrid/Performance/Score
@onready var tidy_text = $Display/Scores/ScoreGrid/Tidiness/Score
@onready var hover_text: Label = $Display/HoverText
@onready var final_score: Label = $EndScreen/StatsBG/Stats/TotalScore/Score
@onready var final_energy: Label = $EndScreen/StatsBG/Stats/FinalStats/Energy/Score
@onready var final_sat: Label = $EndScreen/StatsBG/Stats/FinalStats/Satisfaction/Score
@onready var final_perf: Label = $EndScreen/StatsBG/Stats/FinalStats/Performance/Score
@onready var final_tidy: Label = $EndScreen/StatsBG/Stats/FinalStats/Tidiness/Score
@onready var final_description: Label = $EndScreen/StatsBG/Stats/Description

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.stats_changed.connect(_update_hud)
	GameState.phase_end.connect(_on_phase_end)
	GameState.game_end.connect(_on_game_end)
	GameState.setup_complete.connect(_hud_setup)

func _hud_setup():
	for task in GameState.tasks.values():
		task.hover.connect(_hover_handler)
	for portal in get_tree().get_nodes_in_group("portals"):
		portal.hover.connect(_hover_handler)
	_update_hud()
	game_ready.emit()

func _on_phase_end() -> void:
	$PhaseFlash/ExtraTime.text = str(GameState.carryover)
	$PhaseFlash/Score.text = str(GameState.energy + GameState.satisfaction + GameState.performance + GameState.tidiness)
	$PhaseFlash.show()

func _update_hud() -> void:
	time_text.text = str(GameState.time_left)
	energy_text.text = str(GameState.energy)
	sat_text.text = str(GameState.satisfaction)
	perf_text.text = str(GameState.performance)
	tidy_text.text = str(GameState.tidiness)

func _hover_handler(message: String, enable: bool):
	if enable:
		hover_text.text = message
		hover_text.show()
	else:
		hover_text.hide()

func _on_advance_button_pressed() -> void:
	click_sound.emit()
	advance_phase.emit()
	$PhaseFlash.hide()

func _on_game_end():
	$Display.hide()
	final_score.text = str(GameState.energy + GameState.satisfaction + GameState.performance + GameState.tidiness)
	final_energy.text = str(GameState.energy)
	final_sat.text = str(GameState.satisfaction)
	final_perf.text = str(GameState.performance)
	final_tidy.text = str(GameState.tidiness)
	final_description.text = Endings.generate_description()
	$EndScreen.show()

func _on_quit_pressed() -> void:
	click_sound.emit()
	hide()
	go_to_title.emit()

func _on_restart_pressed() -> void:
	click_sound.emit()
	new_game.emit()

func start_new_game():
	_update_hud()
	$Display.show()
	$EndScreen.hide()
