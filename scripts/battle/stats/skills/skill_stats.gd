class_name SkillStats
extends Resource


@export var title: String = ""
@export var use_type: AbstractSkillUseType
@export var clash_type: AbstractSkillClashType
@export var targeting_type: AbstractSkillTargetingType
@export var icon: Texture2D = Texture2D.new()
@export var abilities: Array[BaseSkillAbility] = []
@export var actions_dice_stats: Array[ActionDiceStats] = []

@export_category("Other")
@export_range(-10, 10, 1, "or_less", "or_greater") var priority: int = 0
@export var targets_setter: BaseTargetsSetter = null


func has_ability() -> bool:
	return abilities.size() > 0
