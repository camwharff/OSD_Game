extends Node

signal stats_changed

var time_left = 20
var tidiness = 0
var energy = 0
var satisfaction = 0
var performance = 0

func apply_task(task: Clickable) -> void:
	time_left -= task.time_cost
	tidiness = clampi(tidiness + task.tidiness_change, 0, 100)
	energy = clampi(energy + task.energy_change, 0, 100)
	satisfaction = clampi(satisfaction + task.satisfaction_change, 0, 100)
	performance = clampi(performance + task.performance_change, 0, 100)
	stats_changed.emit()
