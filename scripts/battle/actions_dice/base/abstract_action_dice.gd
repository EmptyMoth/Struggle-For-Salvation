class_name AbstractActionDice
extends Resource


const _DICE_COLOR_BY_TYPE: Dictionary = {
	BattleEnums.ActionDiceType.ATTACK : Color("E54646"),
	BattleEnums.ActionDiceType.BLOCK : Color("5C8AE5"),
	BattleEnums.ActionDiceType.EVADE : Color("73E573"),
	BattleEnums.ActionDiceType.COUNTER : Color("EEEE48"),
}

var wearer: Character :
	get: return wearer_skill.wearer
var wearer_skill: AbstractSkill

var stats: ActionDiceStats
var values_model: ActionDiceValuesModel
var combat_model: ActionDiceCombatModel

var type: BattleEnums.ActionDiceType :
	get: return stats.dice_type
var color: Color :
	get: return _DICE_COLOR_BY_TYPE[stats.dice_type]


func _init(dice_stats: ActionDiceStats, skill: AbstractSkill) -> void:
	wearer_skill = skill
	stats = dice_stats
	values_model = ActionDiceValuesModel.new(self)
	combat_model = _create_combat_dice()


func _to_string() -> String:
	return "%cD-" + str(values_model.get_current_value())


func create_combat_dice() -> ActionDiceCombatModel:
	combat_model = _create_combat_dice()
	return combat_model


func _create_combat_dice() -> ActionDiceCombatModel:
	match stats.dice_type:
		BattleEnums.ActionDiceType.ATTACK:
			return AttackDice.new(self)
		BattleEnums.ActionDiceType.BLOCK:
			return BlockDice.new(self)
		BattleEnums.ActionDiceType.EVADE:
			return EvadeDice.new(self)
		_:
			return CounterDice.new(self)
