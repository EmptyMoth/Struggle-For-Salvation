class_name ActionDiceUser
extends RefCounted


static func use_dice_in_one_side(character: CharacterCombatModel, target: CharacterCombatModel) -> void:
	var action_dice: AbstractActionDice = character.get_next_dice()
	if action_dice.is_goes_to_reserve:
		character.reserve_current_dice()
		return
	character.try_use_current_dice_in_one_side(target)


static func use_dice_in_clash(opponent_1: CharacterCombatModel, opponent_2: CharacterCombatModel) -> void:
	var interaction: Callable = _get_action_dice_interaction(
			opponent_1.get_next_dice(), opponent_2.get_next_dice())
	interaction.call(opponent_1, opponent_2)


static func _get_action_dice_interaction(
			dice_1: AbstractActionDice, dice_2: AbstractActionDice) -> Callable:
	if dice_1 is AttackDice or dice_2 is AttackDice:
		if dice_1 is CounterDice or dice_2 is CounterDice:
			return ActionDiceUser._implement_respond 
		return ActionDiceUser._implement_clash
	return ActionDiceUser._implement_reserve


static func _implement_reserve(opponent_1: CharacterCombatModel, opponent_2: CharacterCombatModel) -> void:
	opponent_1.reserve_current_dice()
	opponent_2.reserve_current_dice()


static func _implement_respond(opponent_1: CharacterCombatModel, opponent_2: CharacterCombatModel) -> void:
	var first_is_responds: bool = opponent_1.current_action_dice.is_responds
	var respondent: CharacterCombatModel = opponent_1 if first_is_responds else opponent_2
	var initiator: CharacterCombatModel = opponent_2 if first_is_responds else opponent_1
	initiator.try_use_current_dice_in_one_side(respondent)
	respondent.try_use_current_dice_in_one_side(initiator)


static func _implement_clash(opponent_1: CharacterCombatModel, opponent_2: CharacterCombatModel) -> void:
	var clash_result: Dictionary = _get_clash_result(opponent_1, opponent_2)
	opponent_1.try_use_current_dice_in_clash(opponent_2, clash_result[opponent_1])
	opponent_2.try_use_current_dice_in_clash(opponent_1, clash_result[opponent_2])


static func _get_clash_result(opponent_1: CharacterCombatModel, opponent_2: CharacterCombatModel) -> Dictionary:
	var value_1: int = opponent_1.current_skill.calculate_value_for_clash.call(opponent_2.current_skill)
	var value_2: int = opponent_2.current_skill.calculate_value_for_clash.call(opponent_1.current_skill)
	if value_1 > value_2:
		return { opponent_1: BattleEnums.ClashResult.WIN, opponent_2: BattleEnums.ClashResult.LOSE }
	elif value_1 < value_2:
		return { opponent_1: BattleEnums.ClashResult.LOSE, opponent_2: BattleEnums.ClashResult.WIN }
	return { opponent_1: BattleEnums.ClashResult.DRAW, opponent_2: BattleEnums.ClashResult.DRAW }
