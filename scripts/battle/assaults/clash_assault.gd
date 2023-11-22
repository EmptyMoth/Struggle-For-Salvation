class_name ClashAssault
extends AbstractAssault


func can_be_executed() -> bool:
	return super() and _target.can_assault(_target_atp_slot)


func _execute() -> void:
	BattleSignals.clash_started.emit(_character, _target)
	while _can_continue_assault():
		await ActionDiceUser.use_dice_in_clash(_character, _target)
	BattleSignals.clash_ended.emit(_character, _target)
	
	if _character.can_continue_assault():
		await ActionDiceUser.use_dice_in_one_side(_character, _target)
	elif _target.can_continue_assault():
		await ActionDiceUser.use_dice_in_one_side(_target, _character)


func _move_characters() -> void:
	_character.movement_model.move_to_clash(_target)
	_target.movement_model.move_to_clash(_character)
	await _target.movement_model.came_to_position


func _join_assault() -> void:
	super()
	_target.join_assault(_target_atp_slot)


func _leave_assault() -> void:
	super()
	_target.finish_assault()


func _can_continue_assault() -> bool:
	return (_character.can_continue_assault() and _target.can_continue_assault()) \
			or (_character.can_continue_assault() and _target.can_fight_back()) \
			or  (_character.can_fight_back() and _target.can_continue_assault())
