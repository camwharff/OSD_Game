extends Node

const SAVE_PATH = "user://run_history.json"
var runs: Array = []


func _ready():
	load_runs()


func add_run(data: Dictionary):
	runs.append(data)
	save_runs()


func save_runs():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(runs, "\t"))


func load_runs():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		var json = JSON.new()
		if json.parse(file.get_as_text()) == OK:
			runs = json.get_data()
