class_name AutoArrangeAssaults
extends RefCounted


static func arranges_enemies() -> void:
	_auto_arranges_characters_assaults(BattleEnums.Fraction.ENEMY, BattleEnums.Fraction.ALLY)

static func arranges_allies() -> void:
	_auto_arranges_characters_assaults(BattleEnums.Fraction.ALLY, BattleEnums.Fraction.ENEMY)


static func _auto_arranges_characters_assaults(
		fraction_characters: BattleEnums.Fraction,
		fraction_opponents: BattleEnums.Fraction) -> void:
	var characters: Array[Character] = BattleGroups.get_fraction_group(fraction_characters)
	var opponents: Array[Character] = BattleGroups.get_fraction_group(fraction_opponents)
	for character: Character in characters:
		character.auto_set_assault(opponents)
