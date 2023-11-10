class_name ClashAssault
extends AbstractAssault


func can_be_executed() -> bool:
	return super() and _target.can_assault(_target_atp_slot)


func _main_use_actions_dice() -> void:
	ActionDiceUser.use_dice_in_clash(_character, _target)


func _additional_use_actions_dice() -> void:
	if _character.can_continue_assault():
		ActionDiceUser.use_dice_in_one_side(_character, _target)
	elif _target.can_continue_assault():
		ActionDiceUser.use_dice_in_one_side(_target, _character)


func _move_characters() -> void:
	_character.move_to(_target, true)
	await _target.move_to(_character, true)


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
