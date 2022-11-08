extends Node


@onready var _random: RandomNumberGenerator = RandomNumberGenerator.new()
var random: RandomNumberGenerator :
	get: return _random


func _ready() -> void:
	_random.randomize()


func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("ui_menu"):
		get_tree().quit()
