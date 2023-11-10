class_name OneSideAssault
extends AbstractAssault


func execute() -> void:
	await super()
	_character.finish_assault()
	executed.emit()


func _execute() -> void:
	AssaultsRealization.realize_one_side(_character, _target)


func _move_characters() -> void:
	await _character.move_to(_target, false)
	#while _character.on_move:
	#	pass


func _join_assault() -> void:
	_character.join_assault(_character_atp_slot)


func _can_continue_assault() -> bool:
	return _character.can_continue_assault()
