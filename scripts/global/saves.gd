extends Node


const SAVE_VALIDATION_ARRAY: Array = [
	["lungs", "test", false],
	["lungs", "1", false],
	["lungs", "2", false],
	["lungs", "3", false]
]

var _save: ConfigHandler


func _ready() -> void:
	_save = ConfigHandler.new("res://save.cfg", SAVE_VALIDATION_ARRAY)
	_save.save_config()


func is_finished(level: String) -> bool:
	var split_level: PackedStringArray = level.split(" ", false)
	return _save.get_value(split_level[0], split_level[1])


func mark_finished(level: String) -> void:
	var split_level: PackedStringArray = level.split(" ", false)
	_save.set_value(split_level[0], split_level[1], true)
	_save.save_config()
