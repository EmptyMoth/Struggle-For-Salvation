class_name SkillCombatModel
extends Resource


var dice_used_list: Array[AbstractActionDice] = []
var dice_reserved_list: Array[AbstractActionDice] = []
var abilities: Array[BaseSkillAbility] = []


var _index_current_dice: int = 0


func _init(stats: SkillStats) -> void:
	abilities = stats.abilities
	for dice_stats in stats.actions_dice_list:
		var action_dice := AbstractActionDice.create_dice(dice_stats)
		dice_used_list.append(action_dice)


func get_current_dice() -> AbstractActionDice:
	return get_dice_at(_index_current_dice)


func get_dice_at(index: int) -> AbstractActionDice:
	if index >= dice_used_list.size():
		return dice_reserved_list[index - dice_used_list.size()]
	return dice_used_list[index]


func get_dice_count() -> int:
	return dice_used_list.size() + dice_reserved_list.size()


func get_next_dice() -> AbstractActionDice:
	for i in range(_index_current_dice, get_dice_count()):
		if not get_current_dice().is_breaked:
			break
		_index_current_dice += 1
	return dice_used_list[_index_current_dice]


func get_next_dice_reserved() -> AbstractActionDice:
	return dice_reserved_list[_index_current_dice]
