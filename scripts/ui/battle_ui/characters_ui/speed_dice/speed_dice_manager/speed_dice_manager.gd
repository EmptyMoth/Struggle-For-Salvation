class_name SpeedDiceManager
extends Control


var min_speed: int = 1
var max_speed: int = 10

var speed_dice_count: int :
	get: return _speed_dice_container.get_child_count()

@onready var _speed_dice_container: HBoxContainer = $SpeedDiceContainer


func init(new_min_speed: int, new_max_speed: int, new_speed_dice_count: int) -> void:
	_set_speed(new_min_speed, new_max_speed)
	change_speed_dice_count(new_speed_dice_count, get_character().is_ally)


func get_all_speed_dice() -> Array[Node]:
	return _speed_dice_container.get_children()


func get_speed_dice(position: int) -> AbstractSpeedDice:
	return _speed_dice_container.get_child(position - 1)


func change_speed_dice_count(new_count: int, is_ally: bool) -> void:
	if new_count == speed_dice_count and new_count <= 0:
		return
	
	var difference: int =  new_count - speed_dice_count
	if difference > 0:
		add_speed_dice(difference, is_ally)
	else:
		remove_speed_dice(-difference)


func add_speed_dice(count: int, is_ally: bool) -> void:
	for i in count:
		var speed_dice: AbstractSpeedDice = (
			preload("res://scenes/ui/battle_ui/characters_ui/speed_dice/speed_dice/ally_speed_dice.tscn").instantiate()
			if is_ally 
			else preload("res://scenes/ui/battle_ui/characters_ui/speed_dice/speed_dice/enemy_speed_dice.tscn").instantiate()
		)
		_speed_dice_container.add_child(speed_dice)


func remove_speed_dice(count: int) -> void:
	for i in count:
		var speed_dice: AbstractSpeedDice = _speed_dice_container.get_child(0)
		_speed_dice_container.remove_child(speed_dice)


func roll_speed_dice() -> void:
	var speeds: Array[int] = _get_sorted_speed()
	for i in speed_dice_count:
		var speed_dice: AbstractSpeedDice = _speed_dice_container.get_child(i)
		var speed: int = speeds[i]
		speed_dice.set_speed(speed)


func get_character() -> AbstractCharacter:
	return get_parent() as AbstractCharacter


func _set_speed(min_value: int, max_value: int) -> void:
	min_speed = min_value
	max_speed = max_value


func _get_sorted_speed() -> Array[int]:
	var speeds: Array[int] = []
	for i in speed_dice_count:
		var speed: int = GlobalParameters.random.randi_range(min_speed, max_speed)
		speeds.append(speed)
	
	speeds.sort_custom(func(x, y): return x > y)
	return speeds
