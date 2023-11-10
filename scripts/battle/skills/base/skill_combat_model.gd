class_name SkillCombatModel
extends Resource


var dice_count: int :
	get: return actions_dice.size()
var is_available: int :
	get: return not is_used and not is_destroyed

var calculate_value_for_clash: Callable
var actions_dice: Array = []#[AbstractActionDice] = []
var abilities: Array[BaseSkillAbility] = []

var is_used: bool :
	get: return not there_is_dice_available()
var is_destroyed: bool = false

var wearer: CharacterCombatModel

var _index_current_dice: int = 0
var _last_used_dice: AbstractActionDice


func _init(stats: SkillStats, character: Character) -> void:
	wearer = character.get_combat_model()
	calculate_value_for_clash = stats.clash_type.calculate_value_to_compare_in_clash
	abilities = stats.abilities
	actions_dice = stats.actions_dice_stats.map(func(dice_stats: ActionDiceStats): 
			return dice_stats.create_dice(self))


func there_is_dice_available() -> bool:
	return _index_current_dice < dice_count or (_last_used_dice and _last_used_dice.is_recycled)


func get_index_current_dice() -> int:
	return _index_current_dice


func get_current_dice() -> AbstractActionDice:
	return _last_used_dice


func get_dice_at(index: int) -> AbstractActionDice:
	if index < 0 or index >= dice_count:
		push_error("incorrect index was passed for taking Action Dice")
	return actions_dice[index]


func get_next_dice() -> AbstractActionDice:
	if _last_used_dice != null and _last_used_dice.is_recycled:
		return _last_used_dice
	if _index_current_dice >= dice_count:
		push_error("incorrect index was passed for taking Action Dice")
	
	_last_used_dice = actions_dice[_index_current_dice]
	_index_current_dice += 1
	return _last_used_dice
