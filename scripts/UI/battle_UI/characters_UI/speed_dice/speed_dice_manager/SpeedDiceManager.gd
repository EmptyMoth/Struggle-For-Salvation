class_name SpeedDiceManager
extends Control


var min_speed: int = 1
var max_speed: int = 10

var speed_dice_count: int = 0 :
	get: return _speed_dice_container.get_child_count()

@onready var _speed_dice_container: HBoxContainer = $HBoxContainer


func set_speed(min_value: int, max_value: int) -> void:
	min_speed = min_value
	max_speed = max_value


func change_speed_dice_count(new_count: int) -> void:
	if new_count == speed_dice_count and new_count <= 0:
		return
	
	if new_count > speed_dice_count:
		add_speed_dice(new_count - speed_dice_count)
	else:
		remove_speed_dice(speed_dice_count - new_count)


func add_speed_dice(count: int) -> void:
	for i in count:
		var speed_dice: BaseSpeedDice = preload("res://scenes/UI/battle_UI/characters_UI/speed_dice/speed_dice/BaseSpeedDice.tscn").instantiate()
		_speed_dice_container.add_child(speed_dice)


func remove_speed_dice(count: int) -> void:
	for i in count:
		var speed_dice: BaseSpeedDice = _speed_dice_container.get_child(0)
		_speed_dice_container.remove_child(speed_dice)


func roll_speed_dice() -> void:
	var speed_dice_values: Array[int] = _get_sorted_speed()
	for i in speed_dice_count:
		var speed_dice: BaseSpeedDice = _speed_dice_container.get_child(i)
		var speed: int = speed_dice_values[i]
		speed_dice.set_speed(speed)


func _get_sorted_speed() -> Array[int]:
	var speeds: Array[int] = []
	for i in speed_dice_count:
		var speed: int = GlobalParameters.random.randi_range(min_speed, max_speed)
		speeds.append(speed)
	
	speeds.sort_custom(func(x, y): return x > y)
	return speeds
