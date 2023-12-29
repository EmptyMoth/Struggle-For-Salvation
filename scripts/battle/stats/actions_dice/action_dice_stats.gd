class_name ActionDiceStats
extends Resource


@export var dice_type: BattleEnums.ActionDiceType = BattleEnums.ActionDiceType.ATTACK
@export_range(1, 99, 1) var min_value: int = 1
@export_range(1, 99, 1) var max_value: int = 1
@export var action: Action = null
@export var abilities: Array[BaseActionDiceAbility] = []


func has_ability() -> bool:
	return abilities.size() > 0


func get_color() -> Color:
	return ActionDice._DICE_COLOR_BY_TYPE[dice_type]
