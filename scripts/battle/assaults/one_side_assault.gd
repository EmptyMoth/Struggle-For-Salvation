class_name OneSideAssault
extends AbstractAssault


func _main_use_actions_dice() -> void:
	BattleSignals.one_side_started.emit(_character.model, _target.model)
	await ActionDiceUser.use_dice_in_one_side(_character, _target)


func _move_characters() -> void:
	await _character.move_to(_target, false)


func _can_continue_assault() -> bool:
	return _character.can_continue_assault()
