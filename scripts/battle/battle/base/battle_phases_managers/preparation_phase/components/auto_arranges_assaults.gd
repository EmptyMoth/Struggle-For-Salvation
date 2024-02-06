class_name AutoArrangeAssaults
extends Node


static func arranges_enemies() -> void:
	_auto_arranges_characters_assaults(BattleEnums.Fraction.ENEMY, BattleEnums.Fraction.ALLY)

static func arranges_allies() -> void:
	_auto_arranges_characters_assaults(BattleEnums.Fraction.ALLY, BattleEnums.Fraction.ENEMY)


static func _auto_arranges_characters_assaults(
		fraction_characters: BattleEnums.Fraction,
		fraction_opponents: BattleEnums.Fraction) -> void:
	var characters: Array[Character] = []
	for character: Character in BattleGroups.get_fraction_group(fraction_characters):
		if character.is_active:
			characters.append(character)
	var opponents: Array[Character] = []
	for opponent: Character in BattleGroups.get_fraction_group(fraction_opponents):
		if not opponent.is_dead:
			opponents.append(opponent)
	
	if opponents.size() == 0:
		print("There are no opponents!")
		return
	for character: Character in characters:
		character.auto_set_assault(opponents)
