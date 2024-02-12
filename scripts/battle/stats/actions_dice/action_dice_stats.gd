@tool
class_name ActionDiceStats
extends Resource


@export var dice_type: BattleEnums.ActionDiceType = BattleEnums.ActionDiceType.ATTACK :
	set(value):
		dice_type = value
		match value:
			BattleEnums.ActionDiceType.BLOCK:
				motion = BattleEnums.CharactersMotions.BLOCK
			BattleEnums.ActionDiceType.EVADE:
				motion = BattleEnums.CharactersMotions.EVADE
			_:
				motion = BattleEnums.CharactersMotions.ATTACK_1
@export_range(1, 99, 1) var min_value: int = 1 :
	set(value):
		min_value = value
		if max_value < value:
			max_value = value
@export_range(1, 99, 1) var max_value: int = 1 :
	set(value):
		max_value = value
		if min_value > value:
			min_value = value
@export var motion: BattleEnums.CharactersMotions = BattleEnums.CharactersMotions.ATTACK_1

@export_group("Additional")
@export var action: Action = null
@export var abilities: Array[BaseDiceAbility] = []


func has_ability() -> bool:
	return abilities.size() > 0


func get_color() -> Color:
	return ActionDice._DICE_COLOR_BY_TYPE[dice_type]
