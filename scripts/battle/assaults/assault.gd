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
	return _can_continue_assault()


func execute() -> void:
	await _move_characters()
	_join_assault()
	while _can_continue_assault():
		_execute()


func _execute() -> void:
	pass


func _move_characters() -> void:
	pass


func _join_assault() -> void:
	pass


func _can_continue_assault() -> bool:
	return false
