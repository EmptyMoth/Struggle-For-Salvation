class_name CooldownSkillType
extends AbstractSkillUseType


@export_range(1, 9, 1, "suffix:turn") var cooldown: int = 1

#var is_selected: bool = false
#var current_cooldown: int = 0


#func is_available() -> bool:
#	return not is_selected and current_cooldown <= 0
#
#
#func select() -> void:
#	is_selected = true
#
#func deselect() -> void:
#	is_selected = false
#
#
#func reduce_cooldown(count: int) -> void:
#	current_cooldown = max(0, current_cooldown - count)
#
#func increase_cooldown(count: int) -> void:
#	current_cooldown = current_cooldown + count
#
#
#func update() -> void:
#	is_selected = false
#	if current_cooldown > 0:
#		reduce_cooldown(1)
func is_available(skill: AbstractSkill) -> bool:
	return skill.current_use_count == 0


func select(skill: AbstractSkill) -> void:
	skill.current_use_count = cooldown

func deselect(skill: AbstractSkill) -> void:
	skill.current_use_count = 0


func restore(skill: AbstractSkill) -> void:
	if not is_available(skill):
		reduce_cooldown(skill, 1)
	else:
		skill.current_use_count = 0


func reduce_cooldown(skill: AbstractSkill, count: int) -> void:
	skill.current_use_count = min(0, skill.current_use_count + count)

func increase_cooldown(skill: AbstractSkill, count: int) -> void:
	skill.current_use_count -= count
