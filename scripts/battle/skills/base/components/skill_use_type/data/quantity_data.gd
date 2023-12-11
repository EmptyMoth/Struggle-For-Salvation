class_name QuantityData
extends AbstractSkillUseTypeData


@export_range(1, 5, 1, "suffix:pcs") var quantity: int = 1


func create_use_type() -> AbstractSkillUseType:
	return QuantitySkillType.new(self)
