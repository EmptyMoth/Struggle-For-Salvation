class_name AbstractCharacterState
extends Resource


var model: Character


func _init(character: Character) -> void:
	model = character


func _to_string() -> String:
	return "AbstractCharacterState"


static func get_motions() -> BattleEnums.CharactersMotions:
	push_error("the state has no defined posture")
	return BattleEnums.CharactersMotions.DEFAULT
