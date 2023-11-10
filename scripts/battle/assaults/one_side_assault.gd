class_name OneSideAssault
extends AbstractAssault


func _main_use_actions_dice() -> void:
	ActionDiceUser.realize_one_side(_character, _target)


func _move_characters() -> void:
	await _character.move_to(_target, false)


func _join_assault() -> void:
	_character.join_assault(_character_atp_slot)


func _leave_assault() -> void:
	_character.finish_assault()


func _can_continue_assault() -> bool:
	return _character.can_continue_assault()
