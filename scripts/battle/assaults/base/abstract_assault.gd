class_name AbstractAssault
extends Resource


var _initiator_info: CharacterAssaultInfo


func _init(assault_data: AssaultData) -> void:
	_initiator_info = CharacterAssaultInfo.new(assault_data)


static func can_be_executed(data: AssaultData) -> bool:
	return data.atp_slot.assault_can_be_executed() and not data.targets.main.wearer.is_dead


func execute() -> void:
	BattleSignals.assault_started.emit(_initiator_info.character, _initiator_info.opponents.main)
	@warning_ignore("redundant_await")
	await _move_characters()
	_join_assault()
	@warning_ignore("redundant_await")
	await _execute()
	_leave_assault()
	BattleSignals.assault_ended.emit(_initiator_info.character, _initiator_info.opponents.main)


func _execute() -> void:
	pass


func _join_assault() -> void:
	_initiator_info.character.combat_model.join_assault(_initiator_info.attacker_atp_slot)

func _leave_assault() -> void:
	_initiator_info.character.combat_model.finish_assault()


func _move_characters() -> void:
	pass


func _can_continue_assault() -> bool:
	return false
