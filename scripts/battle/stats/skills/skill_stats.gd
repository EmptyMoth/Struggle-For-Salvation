class_name SkillStats
extends Resource


enum SkillType { COOLDOWN, QUANTITY }
enum ClashType  { INDIVIDUAL, SUMMATION }
enum TargetingType { SINGLE, MASS }

@export var title: String = ""
@export var skill_type: SkillType = SkillType.COOLDOWN
@export var clash_type: ClashType = ClashType.INDIVIDUAL
@export var icon: Texture2D = Texture2D.new()
@export var abilities: Array[BaseSkillAbility] = []
@export var actions_dice_stats: Array[ActionDiceStats] = []

@export_category("Cooldown Skill")
@export_range(1, 9, 1, "or_greater", "suffix:turn") var cooldown: int = 1

@export_category("Quantity Skill")
@export_range(1, 5, 1, "or_greater", "suffix:pcs") var quantity: int = 1

@export_category("Other")
@export_range(-10, 10, 1, "or_less", "or_greater") var priority: int = 0
@export var targets_setter: BaseTargetsSetter = null

var targeting_type: TargetingType = TargetingType.SINGLE


func has_ability() -> bool:
	return abilities.size() > 0


func get_targets_count() -> int:
	if self is MassSkillStats:
		return self._targeting_count
	return 1
