@tool
extends Node

@export_tool_button("Run tool") var run_tool = _run_tool


func _run_tool() -> void:
	if not Engine.is_editor_hint():
		return
	var script = load("res://editor_tools.gd") # an EditorScript
	script.new()._run()
