class_name AbstractSkillStats
extends Resource


enum RangeType { MELEE, RANGE, MASS_SUMMATION, MASS_INDIVIDUAL }

@export var icon: Texture2D = Texture2D.new()
@export_multiline var title: String = ""
@export var range_type: RangeType = RangeType.MELEE
#@export var application_type: ApplicationType = ApplicationType.COOLDOWN
#@export_range(1, 10, 1, "or_greater") var application_type_count: int = 1
@export var abilities: Array[BaseSkillAbility] = []
@export var actions_dice_list: Array[AbstractActionDice] = []


func has_ability() -> bool:
	return abilities.size() > 0
