class_name CooldownData
extends AbstractSkillUseTypeData


@export_range(1, 9, 1, "suffix:turn") var cooldown: int = 1


func create_use_type() -> AbstractSkillUseType:
	return CooldownSkillType.new(self)
