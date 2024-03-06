class_name ActionsManager
extends Node


static var _RESERVE_DICE_SOLO: Action = Action.new([
		ActionPart.new(StopMotion.DEFAULT, NothingMotion.DEFAULT)])
static var _RESERVE_DICE_DUAL: Action = Action.new([
		ActionPart.new(StopMotion.DEFAULT, StopMotion.DEFAULT)])


static func execute_win(winner: Character, opponents: Opponents) -> void:
	var winner_dice: ActionDiceCombatModel = winner.combat_model.current_action_dice.combat_model
	if winner_dice is AttackDice:
		await _execute_attack(winner, opponents)
	elif winner_dice is BlockDice:
		await _execute_blocked_attack(winner, opponents.main)
	elif winner_dice is EvadeDice:
		await _execute_evaded_attack(winner, opponents.main)


static func execute_draw(opponent_1: Character, opponent_2: Character) -> void:
	var dice_1: ActionDiceCombatModel = opponent_1.combat_model.current_action_dice.combat_model
	var dice_2: ActionDiceCombatModel = opponent_2.combat_model.current_action_dice.combat_model
	var attack_dice: AttackDice = dice_1 if dice_1 is AttackDice else dice_2
	var not_main_attack_dice: ActionDiceCombatModel = dice_2 if dice_1 == attack_dice else dice_1
	var func_of_execute_action: Callable
	if not_main_attack_dice is AttackDice:
		func_of_execute_action = ActionsManager._execute_draw_in_attack
	elif not_main_attack_dice is BlockDice:
		func_of_execute_action = ActionsManager._execute_blocked_attack
	elif not_main_attack_dice is EvadeDice:
		func_of_execute_action = ActionsManager._execute_evaded_attack
	await func_of_execute_action.call(not_main_attack_dice.model.wearer, attack_dice.model.wearer)


static func execute_dice_reserve(opponent_1: Character, opponent_2: Character, is_clash: bool) -> void:
	var reserve_action: Action = _RESERVE_DICE_DUAL if is_clash else _RESERVE_DICE_SOLO
	reserve_action.execute(opponent_1, opponent_2)
	await reserve_action.finished


static func _execute_draw_in_attack(opponent_1: Character, opponent_2: Character) -> void:
	var draw_in_attacks: Action = Action.new([
		ActionPart.new(
			DefaultAttackMotion.new(opponent_1.combat_model.current_action_dice.stats.motion),
			DefaultAttackMotion.new(opponent_2.combat_model.current_action_dice.stats.motion)
		),
		ActionPart.new(
			KnockbackMotion.new(3, opponent_1.combat_model.current_action_dice.stats.motion),
			KnockbackMotion.new(3, opponent_2.combat_model.current_action_dice.stats.motion)
		)
	])
	draw_in_attacks.execute(opponent_1, opponent_2)
	await draw_in_attacks.finished


static func _execute_evaded_attack(defending: Character, attacker: Character) -> void:
	var evaded_attack: Action = Action.new([
		ActionPart.new(
			EvadeMotion.DEFAULT,
			DefaultAttackMotion.new(attacker.combat_model.current_action_dice.stats.motion)
		)
	])
	evaded_attack.execute(defending, attacker)
	await evaded_attack.finished


static func _execute_blocked_attack(defending: Character, attacker: Character) -> void:
	var blocked_attack: Action = Action.new([
		ActionPart.new(
			BlockMotion.DEFAULT,
			DefaultAttackMotion.new(attacker.combat_model.current_action_dice.stats.motion)
		),
		ActionPart.new(
			BlockMotion.DEFAULT,
			DamageMotion.DEFAULT
		)
	])
	blocked_attack.execute(defending, attacker)
	await blocked_attack.finished


static func _execute_attack(user: Character, opponents: Opponents) -> void:
	var dice: ActionDice = user.combat_model.current_action_dice
	var attack: Action = dice.stats.action \
		if dice.stats.action != null \
		else Action.new([ActionPart.new(
			DefaultAttackMotion.new(user.combat_model.current_action_dice.stats.motion), 
			DamageMotion.DEFAULT
			)])
	attack.execute(user, opponents.main, opponents.sub_targets)
	await attack.finished
