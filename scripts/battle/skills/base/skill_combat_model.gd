class_name SkillCombatModel
extends Resource


var dice_count: int :
	get: return actions_dice.size()
var is_available: int :
	get: return not is_used and not is_destroyed
var is_used: bool :
	get: return not there_is_dice_available()
var is_destroyed: bool = false

var wearer: CharacterCombatModel
var model: AbstractSkill

var actions_dice: Array[ActionDiceCombatModel]
var abilities: Array[BaseSkillAbility]

var _index_next_dice: int = 0
var _last_used_dice: ActionDiceCombatModel


func _init(skill: AbstractSkill, character: Character) -> void:
	wearer = character.get_combat_model()
	model = skill
	abilities = model.stats.abilities
	actions_dice.assign(model.actions_dice.map(
			func(dice: AbstractActionDice): return dice.create_combat_dice(self)))


func there_is_dice_available() -> bool:
	return _index_next_dice < dice_count or (_last_used_dice and _last_used_dice.is_recycled)


func get_index_current_dice() -> int:
	return _index_next_dice - 1


func get_dice_available() -> Array[ActionDiceCombatModel]:
	return actions_dice.slice(_index_next_dice)


func get_current_dice() -> ActionDiceCombatModel:
	return _last_used_dice


func get_dice_at(index: int) -> ActionDiceCombatModel:
	if index < 0 or index >= dice_count:
		push_error("incorrect index was passed for taking Action Dice")
	return actions_dice[index]


func get_next_dice() -> ActionDiceCombatModel:
	if _last_used_dice != null and _last_used_dice.is_recycled:
		return _last_used_dice
	if _index_next_dice >= dice_count:
		push_error("incorrect index was passed for taking Action Dice")
	
	_last_used_dice = actions_dice[_index_next_dice]
	_index_next_dice += 1
	return _last_used_dice


func calculate_comparing_value(opponent_skill: SkillCombatModel) -> int:
	return model.stats.clash_type.calculate_comparing_value(opponent_skill)
