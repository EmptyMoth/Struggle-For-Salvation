class_name StunState
extends AbstractCharacterState


var _is_turn_on_stun_started: bool = false


func _init(character: Character) -> void:
	BattleSignals.turn_started.connect(_on_battle_turn_started)
	BattleSignals.preparation_started.connect(_on_battle_preparation_started)
	super(character)
	print("%s is STUN!" % model)
	character.stunned.emit()


func _to_string() -> String:
	return "StunState"


static func get_motions() -> BattleEnums.CharactersMotions: 
	return BattleEnums.CharactersMotions.STUN


func _on_battle_turn_started() -> void:
	if _is_turn_on_stun_started:
		_is_turn_on_stun_started = false
		model.came_out_of_stun.emit()


func _on_battle_preparation_started() -> void:
	_is_turn_on_stun_started = true
