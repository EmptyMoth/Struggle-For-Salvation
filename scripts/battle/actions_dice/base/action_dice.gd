class_name ActionDice
extends Resource


const _DICE_COLOR_BY_TYPE: Dictionary = {
	BattleEnums.ActionDiceType.ATTACK : Color("E04B4B"),
	BattleEnums.ActionDiceType.BLOCK : Color("588BF2"),
	BattleEnums.ActionDiceType.EVADE : Color("4BD169"),
	BattleEnums.ActionDiceType.COUNTER : Color("E5E529"),
}

var wearer: Character :
	get: return wearer_skill.wearer
var wearer_skill: Skill

var stats: ActionDiceStats
var values_model: ActionDiceValuesModel
var combat_model: ActionDiceCombatModel

var type: BattleEnums.ActionDiceType :
	get: return stats.dice_type
var color: Color :
	get: return _DICE_COLOR_BY_TYPE[stats.dice_type]


func _init(dice_stats: ActionDiceStats, skill: Skill) -> void:
	wearer_skill = skill
	stats = dice_stats
	for ability: BaseDiceAbility in stats.abilities:
		ability.init(wearer, wearer_skill, self)
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
