class_name MassSkillStats
extends SkillStats


@warning_ignore("unused_private_class_variable")
@export_range(2, 9, 1, "suffix:character") var _targeting_count: int = 2


func _init() -> void:
	targeting_type = SkillStats.TargetingType.MASS
