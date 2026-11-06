extends CanvasLayer

signal new_game
signal to_title
signal click_sound


func _on_menu_pressed() -> void:
	click_sound.emit()
	if $MenuControl/MenuList.visible:
		$MenuControl/MenuList.hide()
	else:
		$MenuControl/MenuList.show()


func _on_exit_pressed() -> void:
	click_sound.emit()
	get_tree().quit()


func _on_restart_pressed() -> void:
	click_sound.emit()
	new_game.emit()


func _on_title_pressed() -> void:
	click_sound.emit()
	to_title.emit()


func _on_credits_pressed() -> void:
	click_sound.emit()
	$History.hide()
	if $Credits.visible:
		$Credits.hide()
	else:
		$Credits.show()


func _on_history_pressed() -> void:
	click_sound.emit()
	$Credits.hide()
	if $History.visible:
		$History.hide()
	else:
		$History.show()


func _input(event: InputEvent) -> void:
	if not $MenuControl/MenuList.visible:
		return
	if event is InputEventMouseButton and event.pressed:
		if not $MenuControl.get_global_rect().has_point(
			$MenuControl.get_global_mouse_position()
		):
			$MenuControl/MenuList.hide()
