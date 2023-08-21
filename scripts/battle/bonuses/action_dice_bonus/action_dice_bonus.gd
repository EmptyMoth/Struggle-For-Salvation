class_name ActionDiceBonus
extends Resource


var power: int = 0
var min_value: int = 0
var max_value: int = 0
var physical_damage: int = 0
var mental_damage: int = 0
var physical_bonus_damage: int = 0
var mental_bonus_damage: int = 0
var ignore_power: bool = false


func _init(
		_power: int = 0,
		_min_value: int = 0, _max_value: int = 0,
		_physical_damage: int = 0, _mental_damage: int = 0,
		_physical_bonus_damage: int = 0, _mental_bonus_damage: int = 0,
		_ignore_power: bool = false) -> void:
	power = _power
	min_value = _min_value
	max_value = _max_value
	physical_damage = _physical_damage
	mental_damage = _mental_damage
	physical_bonus_damage = _physical_bonus_damage
	mental_bonus_damage = _mental_bonus_damage
	ignore_power = _ignore_power
