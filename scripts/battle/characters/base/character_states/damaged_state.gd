class_name DamagedState
extends AbstractCharacterState



func _to_string() -> String:
	return "DamagedState"


static func get_motions() -> BattleEnums.CharactersMotions: 
	return BattleEnums.CharactersMotions.STUN
