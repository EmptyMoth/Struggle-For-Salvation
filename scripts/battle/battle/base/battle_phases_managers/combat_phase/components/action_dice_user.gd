class_name ActionDiceUser
extends RefCounted


static func use_dice_in_one_side(character: CharacterCombatModel, target: CharacterCombatModel) -> void:
	if character.get_next_dice().is_used_in_one_side:
		prints(character, " ---> ", target)
		character.try_use_current_dice_in_one_side(target)
		await GlobalParameters.get_tree().create_timer(1).timeout
	else:
		prints(character, " ---- ")
		character.reserve_current_dice()
		await GlobalParameters.get_tree().create_timer(1).timeout


static func use_dice_in_clash(opponent_1: CharacterCombatModel, opponent_2: CharacterCombatModel) -> void:
	var interaction: Callable = _get_action_dice_interaction(
			opponent_1.get_next_dice(), opponent_2.get_next_dice())
	await interaction.call(opponent_1, opponent_2)


static func _get_action_dice_interaction(dice_1: ActionDiceCombatModel, dice_2: ActionDiceCombatModel) -> Callable:
	if dice_1 is AttackDice or dice_2 is AttackDice:
		if dice_1 is CounterDice or dice_2 is CounterDice:
			return ActionDiceUser._implement_respond 
		return ActionDiceUser._implement_clash
	return ActionDiceUser._implement_reserve


static func _implement_reserve(opponent_1: CharacterCombatModel, opponent_2: CharacterCombatModel) -> void:
	prints(opponent_1, " ---- ", opponent_2)
	opponent_1.reserve_current_dice()
	opponent_2.reserve_current_dice()
	await GlobalParameters.get_tree().create_timer(1).timeout


static func _implement_respond(opponent_1: CharacterCombatModel, opponent_2: CharacterCombatModel) -> void:
	var first_is_responds: bool = opponent_1.current_action_dice.is_avoids_clash
	var respondent: CharacterCombatModel = opponent_1 if first_is_responds else opponent_2
	var initiator: CharacterCombatModel = opponent_2 if first_is_responds else opponent_1
	prints(initiator, " <--> ", respondent)
	initiator.try_use_current_dice_in_one_side(respondent)
	await GlobalParameters.get_tree().create_timer(1).timeout
	respondent.try_use_current_dice_in_one_side(initiator)
	await GlobalParameters.get_tree().create_timer(1).timeout


static func _implement_clash(opponent_1: CharacterCombatModel, opponent_2: CharacterCombatModel) -> void:
	var clash_result: Dictionary = await _get_clash_result(opponent_1, opponent_2)
	prints(opponent_1, " -><- ", opponent_2)
	opponent_1.try_use_current_dice_in_clash(opponent_2, clash_result[opponent_1])
	opponent_2.try_use_current_dice_in_clash(opponent_1, clash_result[opponent_2])
	await GlobalParameters.get_tree().create_timer(1).timeout


static func _get_clash_result(opponent_1: CharacterCombatModel, opponent_2: CharacterCombatModel) -> Dictionary:
	var value_1: int = opponent_1.current_skill.calculate_comparing_value(opponent_2.current_skill)
	var value_2: int = opponent_2.current_skill.calculate_comparing_value(opponent_1.current_skill)
	await GlobalParameters.get_tree().create_timer(1).timeout
	if value_1 > value_2:
		return { opponent_1: BattleEnums.ClashResult.WIN, opponent_2: BattleEnums.ClashResult.LOSE }
	elif value_1 < value_2:
		return { opponent_1: BattleEnums.ClashResult.LOSE, opponent_2: BattleEnums.ClashResult.WIN }
	return { opponent_1: BattleEnums.ClashResult.DRAW, opponent_2: BattleEnums.ClashResult.DRAW }
