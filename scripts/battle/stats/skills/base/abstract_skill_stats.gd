class_name SkillStats
extends Resource


enum SkillType { COOLDOWN, QUANTITY }
enum RangeType { MELEE, RANGE, MASS_SUMMATION, MASS_INDIVIDUAL }


@export var title: String = ""
@export var skill_type: SkillType = SkillType.COOLDOWN
@export var range_type: RangeType = RangeType.MELEE
@export var icon: Texture2D = Texture2D.new()
@export var abilities: Array[BaseSkillAbility] = []
@export var actions_dice_stats: Array[ActionDiceStats] = []

@export_category("Cooldown Skill")
@export_range(1, 9, 1, "or_greater", "suffix:turn") var cooldown: int = 1

@export_category("Quantity Skill")
@export_range(1, 5, 1, "or_greater", "suffix:pcs") var quantity: int = 1

@export_category("Other")
@export_range(-10, 10, 1, "or_less", "or_greater") var priority: int = 0


func has_ability() -> bool:
	return abilities.size() > 0
