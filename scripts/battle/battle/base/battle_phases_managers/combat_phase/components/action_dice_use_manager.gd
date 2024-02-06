class_name ActionDiceUseManager
extends Node


static func use_dice_in_one_side(info: CharacterAssaultInfo) -> void:
	if info.character.combat_model.get_next_dice().combat_model.is_used_in_one_side:
		info.character.movement_model.move_to_one_side(info.opponents.main)
		await info.character.movement_model.came_to_position
		prints(info.character, " ---> ", info.opponents.main)
		info.character.combat_model.try_use_current_dice_in_one_side(info.opponents)
		await ActionsManager.execute_win(info.character, info.opponents)
	else:
		prints(info.character, " ---- ")
		info.character.combat_model.reserve_current_dice()
		await ActionsManager.execute_dice_reserve(info.character, info.opponents.main, false)


static func use_dice_in_clash(info_1: CharacterAssaultInfo, info_2: CharacterAssaultInfo) -> void:
	info_1.character.movement_model.move_to_clash(info_2.character)
	info_2.character.movement_model.move_to_clash(info_1.character)
	await info_1.character.movement_model.came_to_position
	
	BattleSignals.clash_continued.emit(info_1.character, info_2.character)
	var interaction: Callable = _get_action_dice_interaction(
			info_1.character.combat_model.get_next_dice().combat_model, info_2.character.combat_model.get_next_dice().combat_model)
	await interaction.call(info_1, info_2)


static func _get_action_dice_interaction(dice_1: ActionDiceCombatModel, dice_2: ActionDiceCombatModel) -> Callable:
	if dice_1 is AttackDice or dice_2 is AttackDice:
		if dice_1 is CounterDice or dice_2 is CounterDice:
			return ActionDiceUseManager._implement_respond 
		return ActionDiceUseManager._implement_clash
	return ActionDiceUseManager._implement_reserve


static func _implement_reserve(info_1: CharacterAssaultInfo, info_2: CharacterAssaultInfo) -> void:
	prints(info_1.character, " ---- ", info_2.character)
	info_1.character.combat_model.reserve_current_dice()
	info_2.character.combat_model.reserve_current_dice()
	await ActionsManager.execute_dice_reserve(info_1.character, info_2.character, true)


static func _implement_respond(info_1: CharacterAssaultInfo, info_2: CharacterAssaultInfo) -> void:
	var first_is_responds: bool = info_1.character.combat_model.current_action_dice.combat_model.is_avoids_clash
	var respondent_info: CharacterAssaultInfo = info_1 if first_is_responds else info_2
	var initiator_info: CharacterAssaultInfo = info_2 if first_is_responds else info_1
	prints(initiator_info.character, " <--> ", respondent_info.character)
	initiator_info.character.combat_model.try_use_current_dice_in_one_side(respondent_info.opponents)
	await ActionsManager.execute_win(initiator_info.character, initiator_info.opponents)
	respondent_info.character.combat_model.try_use_current_dice_in_one_side(initiator_info.opponents)
	await ActionsManager.execute_win(respondent_info.character, respondent_info.opponents)


static func _implement_clash(info_1: CharacterAssaultInfo, info_2: CharacterAssaultInfo) -> void:
	var clash_result: Dictionary = await _get_clash_result(info_1.character, info_2.character)
	prints(info_1.character, " -><- ", info_2.character)
	info_1.character.combat_model.try_use_current_dice_in_clash(info_2.opponents, clash_result[info_1.character])
	info_2.character.combat_model.try_use_current_dice_in_clash(info_1.opponents, clash_result[info_2.character])
	match clash_result[info_1.character]:
		BattleEnums.ClashResult.WIN:
			await ActionsManager.execute_win(info_1.character, info_1.opponents)
		BattleEnums.ClashResult.LOSE:
			await ActionsManager.execute_win(info_2.character, info_2.opponents)
		_:
			await ActionsManager.execute_draw(info_1.character, info_2.character)


static func _get_clash_result(opponent_1: Character, opponent_2: Character) -> Dictionary:
	var value_1: int = opponent_1.combat_model.calculate_comparing_value(opponent_2.combat_model.current_skill)
	var value_2: int = opponent_2.combat_model.calculate_comparing_value(opponent_1.combat_model.current_skill)
	await GlobalParameters.get_tree().create_timer(1).timeout
	var result: int = clampi(value_1 - value_2, BattleEnums.ClashResult.LOSE, BattleEnums.ClashResult.WIN)
	return { opponent_1: result, opponent_2: -result }
