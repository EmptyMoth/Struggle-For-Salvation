class_name MovementState
extends AbstractCharacterState


func _to_string() -> String:
	return "MovementState"


static func get_motions() -> BattleEnums.CharactersMotions: 
	return BattleEnums.CharactersMotions.MOVEMENT
