class_name OneSideAssault
extends AbstractAssault


func _execute() -> void:
	BattleSignals.one_side_started.emit(_initiator_info.character, _initiator_info.opponents.main)
	while _can_continue_assault():
		await ActionDiceUseManager.use_dice_in_one_side(_initiator_info)


func _move_characters() -> void:
	_initiator_info.character.movement_model.move_to_one_side(_initiator_info.opponents.main)
	await _initiator_info.character.movement_model.came_to_position


func _can_continue_assault() -> bool:
	return _initiator_info.character.combat_model.can_continue_assault() \
			and _initiator_info.opponents.get_all_opponents().any(
				func(character: Character) -> bool: return not character.is_dead)
