class_name DeathState
extends AbstractCharacterState


func _init(character: Character) -> void:
	super(character)
	print("%s is DEAD!" % self)
	character.died.emit()


static func get_motions() -> BattleEnums.CharactersMotions: 
	return BattleEnums.CharactersMotions.DEATH
