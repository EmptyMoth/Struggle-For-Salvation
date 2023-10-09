class_name MassSkillStats
extends SkillStats


enum MassTargetingType { ANY, ALL }

@export var mass_targeting_type: MassTargetingType = MassTargetingType.ALL
@export_range(2, 9, 1, "suffix:character") var _targeting_count: int = 2


func _init() -> void:
	targeting_type = SkillStats.TargetingType.MASS
	assault_setter = BaseAutoAssaultSetter.new()
