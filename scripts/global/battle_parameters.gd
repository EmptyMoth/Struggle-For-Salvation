extends Node


enum AssaultTypes { ONE_SIDE, CLASH } 

enum ClashResults { WIN, DRAW, LOSE }

enum CharactersTypes {
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
	CharactersTypes.IMMUNOCYTE : "immunocytes",
	CharactersTypes.VIRUS : "viruses",
	CharactersTypes.BACTERIA : "bacteria",
	CharactersTypes.PARASITE : "parasites",
	CharactersTypes.FUNGUS : "fungi",
	CharactersTypes.ALLERGEN : "allergens",
	CharactersTypes.CANCER_CELL : "cancer_cells",
}
