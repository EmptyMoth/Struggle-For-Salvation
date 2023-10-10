class_name BattleParameters
extends RefCounted


enum CharactersMotions {
	DEFAULT,
	STUN,
	MOVEMENT,
	BLOCK,
	EVADE,
	SLASH_ATTACK, 
	PIERCE_ATTACK,
	BLUNT_ATTACK,
	SHOT,
	SPECIAL,
	SPECIAL_1,
	SPECIAL_2,
	SPECIAL_3,
	SPECIAL_4,
	SPECIAL_5,
}

const CHARACTERS_GROUPS_BY_FRACTIONS: Dictionary = {
	BattleEnums.Fraction.ALLY : "allies",
	BattleEnums.Fraction.ENEMY : "enemies",
	BattleEnums.Fraction.OTHER : "others",
}

const GROUPS_BY_CHARACTERS_TYPES: Dictionary = {
	BattleEnums.CharacterType.IMMUNOCYTE : "immunocytes",
	BattleEnums.CharacterType.VIRUS : "viruses",
	BattleEnums.CharacterType.BACTERIA : "bacteria",
	BattleEnums.CharacterType.PARASITE : "parasites",
	BattleEnums.CharacterType.FUNGUS : "fungi",
	BattleEnums.CharacterType.ALLERGEN : "allergens",
	BattleEnums.CharacterType.CANCER_CELL : "cancer_cells",
}

static var battle: BaseBattle


static func get_fraction_group(fraction: BattleEnums.Fraction) -> Array[Node]:
	return GlobalParameters.get_nodes_in_group(CHARACTERS_GROUPS_BY_FRACTIONS[fraction])
