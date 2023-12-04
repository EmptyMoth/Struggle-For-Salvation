class_name SkillCombatModel
extends Resource


signal skill_used

var dice_count: int :
	get: return actions_dice.size()
var is_available: int :
	get: return there_is_dice_available() and not is_destroyed
var is_destroyed: bool = false

var model: Skill

var actions_dice: Array[ActionDice] :
	get: return model.actions_dice
var abilities: Array[BaseSkillAbility] :
	get: return model.stats.abilities

var _index_next_dice: int = 0
var _last_used_dice: ActionDice


func _init(skill: Skill) -> void:
	model = skill


func there_is_dice_available() -> bool:
	return _index_next_dice < dice_count or (_last_used_dice and _last_used_dice.combat_model.is_recycled)


func get_index_current_dice() -> int:
	return _index_next_dice - 1


func get_dice_available() -> Array[ActionDice]:
	return actions_dice.slice(_index_next_dice)


func get_current_dice() -> ActionDice:
	return _last_used_dice


func get_dice_at(index: int) -> ActionDice:
	if index < 0 or index >= dice_count:
		push_error("incorrect index was passed for taking Action Dice")
	return actions_dice[index]


func get_next_dice() -> ActionDice:
	if _last_used_dice and _last_used_dice.combat_model.is_recycled:
		return _last_used_dice
	if _index_next_dice >= dice_count:
		push_error("incorrect index was passed for taking Action Dice")
	
	_last_used_dice = actions_dice[_index_next_dice]
	_index_next_dice += 1
	return _last_used_dice


func calculate_comparing_value(opponent_skill: Skill) -> int:
	return model.stats.clash_type.calculate_comparing_value(opponent_skill)
