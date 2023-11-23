class_name OneSideAssault
extends AbstractAssault


func _execute() -> void:
	BattleSignals.one_side_started.emit(_data.character, _data.main_target)
	while _can_continue_assault():
		await ActionDiceUser.use_dice_in_one_side(_data.character, _data.main_target)


func _move_characters() -> void:
	_data.character.movement_model.move_to_one_side(_data.main_target)
	await _data.character.movement_model.came_to_position


func _can_continue_assault() -> bool:
	return _data.character.combat_model.can_continue_assault()
