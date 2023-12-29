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

enum CharactersMotions {
	DEFAULT = 0,
	DAMAGE = -1,
	STUN = -2,
	DEATH = -3,
	MOVEMENT = 1,
	BLOCK = 2,
	EVADE = 3,
	SHOT = 4,
	ATTACK_1,
	ATTACK_2,
	ATTACK_3,
	ATTACK_4,
	ATTACK_5,
	ATTACK_6,
	ATTACK_7,
	ATTACK_8,
	ATTACK_9,
}

enum DamageType {
	Attack,
	Status,
	Ability,
}
