extends Resource


signal executed



func can_be_executed(data: AssaultData) -> bool:
	return data.atp_slot.assault_can_be_executed()


func execute(data: AssaultData) -> void:
	BattleSignals.assault_started.emit(data.character, data.main_target)
	await _move_characters()
	_join_assault()
	await _execute()
	_leave_assault()
	BattleSignals.assault_ended.emit(data.character, data.main_target)
	executed.emit()


func _execute() -> void:
	pass


func _join_assault() -> void:
	_character.combat_model.join_assault(_character_atp_slot)

func _leave_assault() -> void:
	_character.combat_model.finish_assault()


func _move_characters() -> void:
	pass


func _can_continue_assault() -> bool:
	return false
