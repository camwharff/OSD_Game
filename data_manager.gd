@tool
extends Node


func save_task_data():
	var file = FileAccess.open("res://data/tasks.json", FileAccess.WRITE)
	var data = []

	for task in GameState.tasks.values():
		var task_data: Dictionary = { }
		for prop in task.get_property_list():
			if (
				prop["usage"] & PROPERTY_USAGE_SCRIPT_VARIABLE
				and prop["usage"] & PROPERTY_USAGE_EDITOR
			):
				task_data.get_or_add(prop["name"], task.get(prop["name"]))
		data.append({ task.task_name: task_data })

	if file:
		file.store_string(JSON.stringify(data, "\t"))


func load_task_data():
	if not FileAccess.file_exists("res://data/tasks.json"):
		push_error("JSON file not found: res://data/tasks.json")
		return
	var text = FileAccess.get_file_as_string("res://data/tasks.json")
	var data = JSON.parse_string(text)
	if typeof(data) != TYPE_ARRAY:
		push_error("Invalid JSON in res://data/tasks.json")
		return

	for task in data:
		var t: Clickable = GameState.tasks[task.keys()[0]]
		for prop in task[t.task_name].keys():
			t.set(prop, task[t.task_name][prop])
