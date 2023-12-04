class_name QuantitySkillType
extends AbstractSkillUseType


@export_range(1, 5, 1, "suffix:pcs") var quantity: int = 1
#	set(value):
#		quantity = value
#		current_quantity = quantity

#var current_quantity: int = quantity
#
#
#func is_available() -> bool:
#	return current_quantity > 0
#
#
#func select() -> void:
#	current_quantity -= 1
#
#func deselect() -> void:
#	current_quantity += 1
#
#
#func update() -> void:
#	current_quantity = quantity


func is_available(skill: Skill) -> bool:
	return skill.current_use_count > 0


func select(skill: Skill) -> void:
	skill.current_use_count -= 1

func deselect(skill: Skill) -> void:
	skill.current_use_count += 1


func restore(skill: Skill) -> void:
	skill.current_use_count = quantity
