class_name SkillStats
extends Resource


@export var title: String = ""
@export var icon: Texture2D = Texture2D.new()
@export_range(1, 9, 1) var targets_count: int = 1
@export var use_type: AbstractSkillUseTypeData
@export var clash_type: AbstractSkillClashType
@export var actions_dice_stats: Array[ActionDiceStats] = []

@export_group("Additional")
@export var is_unclashable: bool = false
@export var abilities: Array[BaseSkillAbility] = []
@export_range(-10, 10, 1, "or_less", "or_greater") var priority: int = 0
@export var targets_setter: BaseTargetsSetter = null
