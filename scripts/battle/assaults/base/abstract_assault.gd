class_name AbstractAssault
extends Resource


signal executed

var _character: CharacterCombatModel
var _target: CharacterCombatModel

var _character_atp_slot: ATPSlot
var _target_atp_slot: ATPSlot


func _init(assault_data: AssaultData) -> void:
	_character_atp_slot = assault_data.atp_slot
	_character = _character_atp_slot.wearer.get_combat_model()
	_target_atp_slot = assault_data.targets.main
	_target = _target_atp_slot.wearer.get_combat_model()


func can_be_executed() -> bool:
	return _character.can_assault(_character_atp_slot)


func execute() -> void:
	BattleSignals.assault_started.emit(_character.model, _target.model)
	await _move_characters()
	_join_assault()
	while _can_continue_assault():
		await _main_use_actions_dice()
	await _additional_use_actions_dice()
	_leave_assault()
	BattleSignals.assault_ended.emit(_character.model, _target.model)
	executed.emit()


func _main_use_actions_dice() -> void:
	pass

func _additional_use_actions_dice() -> void:
	pass


func _join_assault() -> void:
	_character.join_assault(_character_atp_slot)

func _leave_assault() -> void:
	_character.finish_assault()


func _move_characters() -> void:
	pass


func _can_continue_assault() -> bool:
	return false
