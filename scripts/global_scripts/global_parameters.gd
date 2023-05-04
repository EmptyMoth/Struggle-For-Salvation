extends Node


@onready var random: RandomNumberGenerator = RandomNumberGenerator.new() :
	get: return random


func _ready() -> void:
	random.randomize()


func _input(_event: InputEvent) -> void:
	return
	if Input.is_action_pressed("ui_menu"):
		get_tree().quit()
