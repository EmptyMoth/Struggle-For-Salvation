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


var assaults_by_speed_dice: Dictionary = {
	EnemySpeedDice.new() : [
		[AllySpeedDice.new(), "one-side", EnemySpeedDice.new(), "one_side_arrow", "is_completed"], # 1
		[AllySpeedDice.new(), "clash", EnemySpeedDice.new(),  "clash_arrow", "is_completed"], # 2
		[AllySpeedDice.new(), "one-side", EnemySpeedDice.new(), "one_side_arrow", "is_completed"] # 3
	],
	AllySpeedDice.new() : [
		[EnemySpeedDice.new(), "one-side", AllySpeedDice.new(), "one_side_arrow", "is_completed"], # 4
		[AllySpeedDice.new(), "clash", EnemySpeedDice.new(),  "clash_arrow", "is_completed"] # 2
	]
}

var assaults_by_speed: Dictionary = {
	9 : [
		[EnemySpeedDice.new(), "one-side", AllySpeedDice.new(), "one_side_arrow", "is_completed"], # 4
		[AllySpeedDice.new(), "clash", EnemySpeedDice.new(),  "clash_arrow", "is_completed"], # 2
	],
	5 : [
		[AllySpeedDice.new(), "one-side", EnemySpeedDice.new(), "one_side_arrow", "is_completed"], # 1
		[AllySpeedDice.new(), "clash", EnemySpeedDice.new(),  "clash_arrow", "is_completed"], # 2
		[AllySpeedDice.new(), "one-side", EnemySpeedDice.new(), "one_side_arrow", "is_completed"], # 3
	]
}


var initial_enemy_assault: Dictionary = {
	EnemySpeedDice.new() : AllySpeedDice.new(),
	EnemySpeedDice.new() : AllySpeedDice.new(),
}

var ally_one_side_arrow: Array[ArrowOfClash] = [ArrowOfClash.new(), ArrowOfClash.new()]
var enemy_one_side_arrow: Array[ArrowOfClash] = [ArrowOfClash.new(), ArrowOfClash.new()]
var clashes_arrow: Array[ArrowOfClash] = [ArrowOfClash.new(), ArrowOfClash.new()]

