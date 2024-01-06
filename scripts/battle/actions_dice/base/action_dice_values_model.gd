class_name ActionDiceValuesModel
extends Resource


signal rolled
signal dropped_min_value
signal dropped_max_value

var model: ActionDice

var default_min_value: int :
	get: return model.stats.min_value
var default_max_value: int :
	get: return model.stats.max_value
var default_current_value: int = 0

var abilities: Array[BaseActionDiceAbility]
var bonus: ActionDiceBonus = ActionDiceBonus.new()


func _init(dice: ActionDice) -> void:
	model = dice
	abilities = dice.stats.abilities


func get_min_value() -> int:
	return max(1, default_min_value + bonus.min_value)

func get_max_value() -> int:
	return max(1, default_max_value + bonus.max_value)

func get_current_value() -> int:
	if bonus.ignore_power:
		return default_current_value
	return max(1, default_current_value + bonus.power)


func get_extra_power_multiplier() -> float:
	return get_current_value() / float(default_current_value)


func roll_dice() -> void:
	var min_value: int = get_min_value()
	var max_value: int = get_max_value()
	default_current_value = randi_range(min_value, max_value)
	match default_current_value:
		min_value:
			dropped_min_value.emit()
		max_value:
			dropped_max_value.emit()


func compare_to(opponent_dice: ActionDiceValuesModel) -> int:
	return clampi(get_current_value() - opponent_dice.get_current_value(), -1, 1)
