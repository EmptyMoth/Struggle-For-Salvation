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

var color: Color :
	get: return _DICE_COLOR_BY_TYPE[stats.dice_type]

var default_min_value: int : 
	get: return values_model.default_min_value
var default_max_value: int : 
	get: return values_model.default_max_value
var default_current_value: int : 
	get: return values_model.default_current_value


func _init(dice_stats: ActionDiceStats, skill: AbstractSkill) -> void:
	wearer_skill = skill
	stats = dice_stats
	values_model = ActionDiceValuesModel.new(dice_stats, skill)


func _to_string() -> String:
	return "%cD-" + str(values_model.get_current_value())


func create_combat_dice(skill: SkillCombatModel) -> ActionDiceCombatModel:
	combat_model = _create_combat_dice(skill)
	return combat_model


func get_min_value() -> int: return values_model.get_min_value()

func get_max_value() -> int: return values_model.get_max_value()

func get_current_value() -> int: return values_model.get_current_value()

func roll_dice() -> void: return values_model.roll_dice()

func compare_to(opponent_dice: ActionDiceValuesModel) -> int: return values_model.compare_to(opponent_dice)


func break_dice() -> void: combat_model.break_dice()

func use_in_one_side(target: CharacterCombatModel) -> void: combat_model.use_in_one_side(target)

func use_in_clash(target: CharacterCombatModel, clash_result: BattleEnums.ClashResult) -> void: combat_model.use_in_clash(target, clash_result)


func _create_combat_dice(skill: SkillCombatModel) -> ActionDiceCombatModel:
	match stats.dice_type:
		BattleEnums.ActionDiceType.ATTACK:
			return AttackDice.new(self, skill)
		BattleEnums.ActionDiceType.BLOCK:
			return BlockDice.new(self, skill)
		BattleEnums.ActionDiceType.EVADE:
			return EvadeDice.new(self, skill)
		_:
			return CounterDice.new(self, skill)
