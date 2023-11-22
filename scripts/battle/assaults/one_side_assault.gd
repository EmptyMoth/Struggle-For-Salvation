class_name OneSideAssault
extends AbstractAssault


func _execute() -> void:
	BattleSignals.one_side_started.emit(_character, _target)
	while _can_continue_assault():
		await ActionDiceUser.use_dice_in_one_side(_character, _target)


func _move_characters() -> void:
	_character.movement_model.move_to_one_side(_target)
	await _character.movement_model.came_to_position


func _can_continue_assault() -> bool:
	return _character.combat_model.can_continue_assault()
