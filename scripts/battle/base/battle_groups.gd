class_name BattleGroups
extends RefCounted


const CHARACTERS_GROUP: String = "characters"
const PATHOGENS_GROUP: String = "pathogens"
const ATP_SLOTS_GROUP: String = "atp_slots"

const GROUPS_BY_FRACTIONS: Dictionary = {
	BattleEnums.Fraction.ALLY : "allies",
	BattleEnums.Fraction.ENEMY : "enemies",
}

const GROUPS_BY_ATP_SLOTS_FRACTIONS: Dictionary = {
	BattleEnums.Fraction.ALLY : "allies_atp_slots",
	BattleEnums.Fraction.ENEMY : "enemies_atp_slots",
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

const GROUPS_BY_ASSAULT_ARROWS_TYPES: Dictionary = {
	BaseAssaultArrow.AssaultArrowType.ALLY_ONE_SIDE : "one_sided_allied_arrows",
	BaseAssaultArrow.AssaultArrowType.ENEMY_ONE_SIDE : "one_sided_enemy_arrows",
	BaseAssaultArrow.AssaultArrowType.CLASH : "clashing_arrows",
}


static func get_fraction_group(fraction: BattleEnums.Fraction) -> Array[Character]:
	var result: Array[Character] = []
	result.assign(GlobalParameters.get_nodes_in_group(GROUPS_BY_FRACTIONS[fraction]))
	return result

static func get_atp_slots_fraction_group(fraction: BattleEnums.Fraction) -> Array[BaseATPSlotUI]:
	var result: Array[BaseATPSlotUI] = []
	result.assign(GlobalParameters.get_nodes_in_group(GROUPS_BY_ATP_SLOTS_FRACTIONS[fraction]))
	return result

static func get_assault_arrows_group(arrow_type: BaseAssaultArrow.AssaultArrowType) -> Array[BaseAssaultArrow]:
	var result: Array[BaseAssaultArrow] = []
	result.assign(GlobalParameters.get_nodes_in_group(GROUPS_BY_ASSAULT_ARROWS_TYPES[arrow_type]))
	return result
