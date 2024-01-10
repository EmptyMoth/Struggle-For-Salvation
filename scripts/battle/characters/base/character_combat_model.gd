class_name CharacterCombatModel
extends Resource


signal won_clash(target: Character)
signal drew_clash(target: Character)
signal lost_clash(target: Character)

signal added_to_reserve(action_dice: ActionDice)
signal used_in_one_side(action_dice: ActionDice)
signal used_in_clashed(action_dice: ActionDice)

signal calculated_comparing_value(value: int)
signal used_action_dice(dice: ActionDice)
signal chose_next_action_dice(dice: ActionDice, dice_pool: Array[ActionDice])

var model: Character

var current_atp_slot: ATPSlot = null
var current_skill: Skill = null
var current_action_dice: ActionDice = null
var dice_reserved_list: ActionDiceReservedList = ActionDiceReservedList.new()


func _init(character: Character) -> void:
	model = character


func join_assault(atp_slot: ATPSlot) -> void:
	current_atp_slot = atp_slot
	current_skill = atp_slot.assaulting_skill
	current_skill.use()

func finish_assault() -> void:
	current_atp_slot = null
	current_skill = null
	current_action_dice = null


func can_continue_assault() -> bool:
	return model.is_active and current_skill.combat_model.is_available


func can_fight_back() -> bool:
	return model.is_active and dice_reserved_list.there_is_reserved_dice()


func get_next_dice() -> ActionDice:
	if current_skill.combat_model.there_is_dice_available():
		current_action_dice = current_skill.combat_model.get_next_dice()
		chose_next_action_dice.emit(current_action_dice, current_skill.combat_model.get_dice_available())
	else:
		current_action_dice = dice_reserved_list.dequeue()
		chose_next_action_dice.emit(current_action_dice, dice_reserved_list.get_dice())
	return current_action_dice


func calculate_comparing_value(opponent_skill: Skill) -> int:
	var result: int = opponent_skill.combat_model.calculate_comparing_value(current_skill)
	calculated_comparing_value.emit(result)
	return result


func reserve_current_dice() -> void:
	current_action_dice.combat_model.reserve()
	dice_reserved_list.enqueue(current_action_dice)
	added_to_reserve.emit(current_action_dice)


func try_use_current_dice_in_one_side(targets: Opponents) -> void:
	if not model.is_active:
		return
	current_action_dice.values_model.roll_dice()
	used_action_dice.emit(current_action_dice)
	used_in_one_side.emit(current_action_dice)
	current_action_dice.combat_model.use_in_one_side(targets)


func try_use_current_dice_in_clash(
			targets: Opponents, clash_result: BattleEnums.ClashResult) -> void:
	if not model.is_active:
		return
	match clash_result:
		BattleEnums.ClashResult.WIN:
			won_clash.emit(targets.main)
		BattleEnums.ClashResult.LOSE:
			lost_clash.emit(targets.main)
		_:
			drew_clash.emit(targets.main)
	
	used_action_dice.emit(current_action_dice)
	used_in_clashed.emit(current_action_dice)
	current_action_dice.combat_model.use_in_clash(targets, clash_result)
