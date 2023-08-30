extends Node


enum AssaultType { ONE_SIDE, CLASH } 

enum ClashResult { LOSE = -1, DRAW = 0, WIN = 1 }

enum CharacterType {
	IMMUNOCYTE,
	VIRUS,
	BACTERIA,
	ALLERGEN,
	FUNGUS,
	PARASITE,
	CANCER_CELL,
}

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

const GROUPS_BY_CHARACTERS_TYPES: Dictionary = {
	CharacterType.IMMUNOCYTE : "immunocytes",
	CharacterType.VIRUS : "viruses",
	CharacterType.BACTERIA : "bacteria",
	CharacterType.PARASITE : "parasites",
	CharacterType.FUNGUS : "fungi",
	CharacterType.ALLERGEN : "allergens",
	CharacterType.CANCER_CELL : "cancer_cells",
}

static var battle: BaseBattle
