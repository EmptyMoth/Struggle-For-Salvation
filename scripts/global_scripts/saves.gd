extends Node


const SAVE_VALIDATION_ARRAY: Array = [
	["lungs", "test", false]
]

var _save: ConfigHandler


func _ready():
	_save = ConfigHandler.new("user://save.cfg", SAVE_VALIDATION_ARRAY)
	_save.save_config()


func is_completed(level: String) -> bool:
	var split_level = level.split(" ", false)
	return _save.get_value(split_level[0], split_level[1])


func mark_complete(level: String) -> void:
	var split_level = level.split(" ", false)
	_save.set_value(split_level[0], split_level[1], true)
