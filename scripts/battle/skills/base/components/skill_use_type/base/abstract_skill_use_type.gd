class_name AbstractSkillUseType
extends Resource


#func is_available() -> bool:
#	return true
#
#
#func select() -> void:
#	pass
#
#func deselect() -> void:
#	pass
#
#
#func update() -> void:
#	pass

func is_available(_skill: AbstractSkill) -> bool:
	return true


func select(_skill: AbstractSkill) -> void:
	pass

func deselect(_skill: AbstractSkill) -> void:
	pass


func restore(_skill: AbstractSkill) -> void:
	pass
