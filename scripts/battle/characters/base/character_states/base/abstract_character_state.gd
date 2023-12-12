class_name AbstractCharacterState
extends Resource


var model: Character


func _init(character: Character) -> void:
	model = character


static func get_motions() -> BattleEnums.CharactersMotions:
	push_error("the state has no defined posture")
	return BattleEnums.CharactersMotions.DEFAULT
