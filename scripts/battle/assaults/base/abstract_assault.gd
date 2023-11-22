class_name AbstractAssault
extends Resource


signal executed

var _character: Character
var _target: Character

var _character_atp_slot: ATPSlot
var _target_atp_slot: ATPSlot


func _init(assault_data: AssaultData) -> void:
	_character_atp_slot = assault_data.atp_slot
	_character = _character_atp_slot.wearer
	_target_atp_slot = assault_data.targets.main
	_target = _target_atp_slot.wearer


func can_be_executed() -> bool:
	return _character.combat_model.can_assault(_character_atp_slot)


func execute() -> void:
	BattleSignals.assault_started.emit(_character, _target)
	await _move_characters()
	_join_assault()
	await _execute()
	_leave_assault()
	BattleSignals.assault_ended.emit(_character, _target)
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
