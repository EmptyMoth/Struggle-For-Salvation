class_name DeathState
extends AbstractCharacterState


func _init(character: Character) -> void:
	super(character)
	print("%s is DEAD!" % model)
	character.died.emit()


func _to_string() -> String:
	return "DeathState"


static func get_motions() -> BattleEnums.CharactersMotions: 
	return BattleEnums.CharactersMotions.DEATH
