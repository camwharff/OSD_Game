extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.stats_changed.connect(_update_hud)
	GameState.time_end.connect(_phase_end)
	_update_hud()
	
	for task in get_tree().get_nodes_in_group("tasks"):
		task.hover.connect(_hover_handler)
	for portal in get_tree().get_nodes_in_group("portals"):
		portal.hover.connect(_hover_handler)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _phase_end() -> void:
	$PhaseFlash.show()
	$PhaseFlash/ExtraTime.text = str(GameState.carryover)
	$PhaseFlash/Score.text = str(GameState.energy + GameState.satisfaction + GameState.performance + GameState.tidiness)
	get_tree().paused = true
	

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
