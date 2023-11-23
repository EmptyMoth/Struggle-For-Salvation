class_name AbstractAssault
extends Resource


#var _character: Character
#var _target: Character
#
#var _character_atp_slot: ATPSlot
#var _target_atp_slot: ATPSlot
var _data: AssaultData


func _init(assault_data: AssaultData) -> void:
	_data = assault_data
#	_character_atp_slot = assault_data.atp_slot
#	_character = _character_atp_slot.wearer
#	_target_atp_slot = assault_data.targets.main
#	_target = _target_atp_slot.wearer


static func can_be_executed(data: AssaultData) -> bool:
	return data.atp_slot.assault_can_be_executed()


func execute() -> void:
	BattleSignals.assault_started.emit(_data.character, _data.main_target)
	await _move_characters()
	_join_assault()
	await _execute()
	_leave_assault()
	BattleSignals.assault_ended.emit(_data.character, _data.main_target)


func _execute() -> void:
	pass


func _join_assault() -> void:
	_data.character.combat_model.join_assault(_data.atp_slot)

func _leave_assault() -> void:
	_data.character.combat_model.finish_assault()


func _move_characters() -> void:
	pass


func _can_continue_assault() -> bool:
	return false
