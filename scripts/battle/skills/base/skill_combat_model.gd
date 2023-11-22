class_name SkillCombatModel
extends Resource


signal  skill_used

var dice_count: int :
	get: return actions_dice.size()
var is_available: int :
	get: return not is_used and not is_destroyed
var is_used: bool :
	get: return not there_is_dice_available()
var is_destroyed: bool = false

var model: AbstractSkill

var actions_dice: Array[AbstractActionDice] :
	get: return model.actions_dice
var abilities: Array[BaseSkillAbility] :
	get: return model.stats.abilities

var _index_next_dice: int = 0
var _last_used_dice: AbstractActionDice


func _init(skill: AbstractSkill) -> void:
	model = skill


func there_is_dice_available() -> bool:
	return _index_next_dice < dice_count or (_last_used_dice and _last_used_dice.combat_model.is_recycled)


func get_index_current_dice() -> int:
	return _index_next_dice - 1


func get_dice_available() -> Array[AbstractActionDice]:
	return actions_dice.slice(_index_next_dice)


func get_current_dice() -> AbstractActionDice:
	return _last_used_dice


func get_dice_at(index: int) -> AbstractActionDice:
	if index < 0 or index >= dice_count:
		push_error("incorrect index was passed for taking Action Dice")
	return actions_dice[index]


func get_next_dice() -> AbstractActionDice:
	if _last_used_dice and _last_used_dice.combat_model.is_recycled:
		return _last_used_dice
	if _index_next_dice >= dice_count:
		push_error("incorrect index was passed for taking Action Dice")
	
	_last_used_dice = actions_dice[_index_next_dice]
	_index_next_dice += 1
	return _last_used_dice


func use() -> void:
	skill_used.emit()


func calculate_comparing_value(opponent_skill: AbstractSkill) -> int:
	return model.stats.clash_type.calculate_comparing_value(opponent_skill)
