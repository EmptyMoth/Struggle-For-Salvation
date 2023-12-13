class_name DefaultState
extends AbstractCharacterState


func _to_string() -> String:
	return "DefaultState"


static func get_motions() -> BattleEnums.CharactersMotions: 
	return BattleEnums.CharactersMotions.DEFAULT
