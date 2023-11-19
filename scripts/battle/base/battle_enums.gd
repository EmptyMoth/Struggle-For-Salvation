class_name BattleEnums
extends Object


enum Fraction { ENEMY = -1, OTHER = 0, ALLY = 1 }

enum BattlePhase { PREPARATION, COMBAT }

enum AssaultType { ONE_SIDE, CLASH }

enum ClashResult { LOSE = -1, DRAW = 0, WIN = 1 }

enum ActionDiceType { ATTACK, BLOCK, EVADE, COUNTER }

enum CharacterType {
	IMMUNOCYTE,
	VIRUS,
	BACTERIA,
	ALLERGEN,
	FUNGUS,
	PARASITE,
	CANCER_CELL,
}
