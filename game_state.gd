extends Node

signal stats_changed
signal time_end

var time_left: int = 0
var time_max: int = 0
var tidiness: int = 0
var energy: int = 0
var satisfaction: int = 0
var performance: int = 0
var carryover: int = 0
var completed: Dictionary = {}
var tasks: Dictionary = {}
var dependencies: Dictionary = {}

func _ready():
	get_viewport().physics_object_picking_sort = true
	get_viewport().physics_object_picking_first_only = true
	init_tasks()
	build_dependencies()

func _process(_delta):
	if time_left <= 0:
		time_end.emit()

func init_tasks():
	for task in get_tree().get_nodes_in_group("tasks"):
		tasks[task.task_name] = task

func build_dependencies():
	for task in tasks.values():
		for other_task in task.prereqs + task.blocked_by:
			dependencies.get_or_add(other_task, []).append(task.task_name)

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
		
	for task in tasks.values():
		if task.begin > time_max - time_left || task.end < time_max - time_left:
			task.enable = false
		else:
			task.enable = true
	
	for task in current_task.dependencies:
		update_availability(tasks[task.task_name])
	
	completed[current_task] = true
	current_task.complete = true
	current_task.complete_task()

func update_availability(task: Clickable):
	if completed[task.task_name]:
		return false
		
	for req in task.requires:
		if !completed[req]:
			return false
	for blocker in task.blocked_by:
		if completed[blocker]:
			return false
	
	return true
