extends Node

signal stats_changed

var time_left = 20
var tidiness = 0
var energy = 0
var satisfaction = 0
var performance = 0

func apply_task(task: Clickable) -> void:
	time_left -= task.time_cost
	tidiness += task.tidiness_change
	energy += task.energy_change
	satisfaction += task.satisfaction_change
	performance += task.performance_change
	stats_changed.emit()
