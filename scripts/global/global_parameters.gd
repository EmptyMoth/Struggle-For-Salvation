extends Node


@onready var random: RandomNumberGenerator = RandomNumberGenerator.new() :
	get: return random


func _ready() -> void:
	random.randomize()
