class_name ActionDiceValuesModel
extends Resource


var wearer: Character :
	get: return wearer_skill.wearer
var wearer_skill: AbstractSkill

var default_min_value: int
var default_max_value: int
var default_current_value: int = 0

var abilities: Array[BaseActionDiceAbility]
var bonus: ActionDiceBonus = ActionDiceBonus.new()


func _init(dice_stats: ActionDiceStats, skill: AbstractSkill) -> void:
	wearer_skill = skill
	default_min_value = dice_stats.min_value
	default_max_value = dice_stats.max_value
	abilities = dice_stats.abilities


func get_min_value() -> int:
	return max(1, default_min_value + bonus.min_value)

func get_max_value() -> int:
	return max(1, default_max_value + bonus.max_value)

func get_current_value() -> int:
	if bonus.ignore_power:
		return default_current_value
	return max(1, default_current_value + bonus.power)


func roll_dice() -> void:
	default_current_value = randi_range(get_min_value(), get_max_value())


func compare_to(opponent_dice: ActionDiceValuesModel) -> int:
	return clampi(get_current_value() - opponent_dice.get_current_value(), -1, 1)
