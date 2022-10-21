extends Node


@onready var _random: RandomNumberGenerator = RandomNumberGenerator.new()
var random: RandomNumberGenerator :
	get: return _random


func _ready() -> void:
	_random.randomize()
