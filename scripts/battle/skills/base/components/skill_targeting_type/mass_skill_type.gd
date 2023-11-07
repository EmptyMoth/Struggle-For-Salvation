class_name MassSkillType
extends AbstractSkillTargetingType


@export_range(2, 9, 1, "suffix:character") var _targeting_count: int = 2


func get_targets_count() -> int:
	return _targeting_count
