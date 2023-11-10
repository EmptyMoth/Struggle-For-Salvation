class_name ClashAssault
extends AbstractAssault


func execute() -> void:
	await super()
	if _character.can_continue_assault():
		AssaultsRealization.realize_one_side(_character, _target)
	elif _target.can_continue_assault():
		AssaultsRealization.realize_one_side(_target, _character)
	_character.finish_assault()
	_target.finish_assault()
	executed.emit()


func _execute() -> void:
	AssaultsRealization.realize_clash(_character, _target)


func _move_characters() -> void:
	_character.move_to(_target, true)
	await _target.move_to(_character, true)


func _join_assault() -> void:
	_character.join_assault(_character_atp_slot)
	_target.join_assault(_target_atp_slot)


func _can_continue_assault() -> bool:
	return (_character.can_continue_assault() and _target.can_continue_assault()) \
			or (_character.can_continue_assault() and _target.can_fight_back()) \
			or  (_character.can_fight_back() and _target.can_continue_assault())
