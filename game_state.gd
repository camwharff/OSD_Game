extends Node

signal stats_changed
signal time_end

var time_left = 0
var time_max = 0
var tidiness = 0
var energy = 0
var satisfaction = 0
var performance = 0
var carryover = 0

func _ready():
	get_viewport().physics_object_picking_sort = true
	get_viewport().physics_object_picking_first_only = true

func _process(_delta):
	if time_left <= 0:
		time_end.emit()

func start_phase(time_limit: int):
	time_left = time_limit + carryover
	time_max = time_left
	carryover = 0

func apply_task(current_task: Clickable) -> void:
	time_left = clampi(time_left - current_task.time_cost, 0, 100)
	tidiness += current_task.tidiness_change
	energy += current_task.energy_change
	satisfaction += current_task.satisfaction_change
	performance += current_task.performance_change
	stats_changed.emit()
	if current_task.early_exit:
		carryover = time_left
		time_left = 0
	if time_left <= 0:
		time_end.emit()
	for task in get_tree().get_nodes_in_group("tasks"):
		if task.begin > time_max - time_left || task.end < time_max - time_left:
			task.enable = false
		else:
			task.enable = true
	current_task.complete = true
	current_task.complete_task()
