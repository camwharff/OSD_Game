extends CanvasLayer

signal advance_phase
signal game_ready

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.stats_changed.connect(_update_hud)
	GameState.time_end.connect(_phase_end_display)
	GameState.setup_complete.connect(_hud_setup)

func _hud_setup():
	for task in GameState.tasks.values():
		task.hover.connect(_hover_handler)
	for portal in get_tree().get_nodes_in_group("portals"):
		portal.hover.connect(_hover_handler)
	_update_hud()
	game_ready.emit()

func _phase_end_display() -> void:
	$PhaseFlash.show()
	$PhaseFlash/ExtraTime.text = str(GameState.carryover)
	$PhaseFlash/Score.text = str(GameState.energy + GameState.satisfaction + GameState.performance + GameState.tidiness)

func _update_hud() -> void:
	$Time.text = str(GameState.time_left)
	$Energy.text = str(GameState.energy)
	$Satisfaction.text = str(GameState.satisfaction)
	$Performance.text = str(GameState.performance)
	$Tidiness.text = str(GameState.tidiness)

func _hover_handler(message: String, enable: bool):
	if enable:
		$HoverInfo/HoverText.text = message
		$HoverInfo.show()
	else:
		$HoverInfo.hide()

func _on_advance_button_pressed() -> void:
	advance_phase.emit()
	$PhaseFlash.hide()
	
