class_name ActionDiceUser
extends RefCounted


static func use_dice_in_one_side(character: Character, target: Character) -> void:
	if character.combat_model.get_next_dice().combat_model.is_used_in_one_side:
		character.movement_model.move_to_one_side(target)
		await character.movement_model.came_to_position
		prints(character, " ---> ", target)
		character.combat_model.try_use_current_dice_in_one_side(target)
		await GlobalParameters.get_tree().create_timer(1).timeout
	else:
		prints(character, " ---- ")
		character.combat_model.reserve_current_dice()
		await GlobalParameters.get_tree().create_timer(1).timeout


static func use_dice_in_clash(opponent_1: Character, opponent_2: Character) -> void:
	opponent_1.movement_model.move_to_clash(opponent_2)
	opponent_2.movement_model.move_to_clash(opponent_1)
	await opponent_1.movement_model.came_to_position
	
	BattleSignals.assault_continued.emit(opponent_1, opponent_2)
	var interaction: Callable = _get_action_dice_interaction(
			opponent_1.get_next_dice().combat_model, opponent_2.get_next_dice().combat_model)
	await interaction.call(opponent_1, opponent_2)


static func _get_action_dice_interaction(dice_1: ActionDiceCombatModel, dice_2: ActionDiceCombatModel) -> Callable:
	if dice_1 is AttackDice or dice_2 is AttackDice:
		if dice_1 is CounterDice or dice_2 is CounterDice:
			return ActionDiceUser._implement_respond 
		return ActionDiceUser._implement_clash
	return ActionDiceUser._implement_reserve


static func _implement_reserve(opponent_1: Character, opponent_2: Character) -> void:
	prints(opponent_1, " ---- ", opponent_2)
	opponent_1.reserve_current_dice()
	opponent_2.reserve_current_dice()
	await GlobalParameters.get_tree().create_timer(1).timeout


static func _implement_respond(opponent_1: Character, opponent_2: Character) -> void:
	var first_is_responds: bool = opponent_1.current_action_dice.is_avoids_clash
	var respondent: Character = opponent_1 if first_is_responds else opponent_2
	var initiator: Character = opponent_2 if first_is_responds else opponent_1
	prints(initiator, " <--> ", respondent)
	initiator.try_use_current_dice_in_one_side(respondent)
	await GlobalParameters.get_tree().create_timer(1).timeout
	respondent.try_use_current_dice_in_one_side(initiator)
	await GlobalParameters.get_tree().create_timer(1).timeout


static func _implement_clash(opponent_1: Character, opponent_2: Character) -> void:
	var clash_result: Dictionary = await _get_clash_result(opponent_1, opponent_2)
	prints(opponent_1, " -><- ", opponent_2)
	opponent_1.try_use_current_dice_in_clash(opponent_2, clash_result[opponent_1])
	opponent_2.try_use_current_dice_in_clash(opponent_1, clash_result[opponent_2])
	await GlobalParameters.get_tree().create_timer(1).timeout


static func _get_clash_result(opponent_1: Character, opponent_2: Character) -> Dictionary:
	var value_1: int = opponent_1.combat_model.calculate_comparing_value(opponent_2.current_skill)
	var value_2: int = opponent_2.combat_model.calculate_comparing_value(opponent_1.current_skill)
	await GlobalParameters.get_tree().create_timer(1).timeout
	var result: int = clampi(value_1 - value_2, BattleEnums.ClashResult.LOSE, BattleEnums.ClashResult.WIN)
	return { opponent_1: result, opponent_2: -result }
