class_name ActionDiceCombatModel
extends Resource


signal destroyed
signal used
signal rolled

var wearer: CharacterCombatModel :
	get: return wearer_skill.wearer
var wearer_skill: SkillCombatModel
var model: AbstractActionDice

var stats: ActionDiceStats
var values_model: ActionDiceValuesModel

var is_used_in_one_side: bool = false
var is_avoids_clash: bool = false

var is_used: bool = false
var is_reserved: bool = false
var is_recycled: bool = false
var is_destroyed: bool = false


func _init(dice: AbstractActionDice, skill: SkillCombatModel) -> void:
	model = dice
	stats = dice.stats
	wearer_skill = skill


func _to_string() -> String:
	return "%cD-" + str(model.values_model.get_current_value())


func roll_dice() -> void:
	model.values_model.roll_dice()
	rolled.emit()


func compare_to(opponent_dice: AbstractActionDice) -> int:
	return values_model.compare_to(opponent_dice.values_model)


func break_dice() -> void:
	destroyed.emit()


func use_in_one_side(target: CharacterCombatModel) -> void:
	is_used = true
	used.emit()


func use_in_clash(target: CharacterCombatModel, clash_result: BattleEnums.ClashResult) -> void:
	match clash_result:
		BattleEnums.ClashResult.WIN:
			_win_clash(target)
		BattleEnums.ClashResult.LOSE:
			_lose_clash(target)
		_:
			_draw_clash(target)
	used.emit()
	is_used = true


func _win_clash(target: CharacterCombatModel) -> void:
	pass

func _draw_clash(target: CharacterCombatModel) -> void:
	pass

func _lose_clash(target: CharacterCombatModel) -> void:
	pass
