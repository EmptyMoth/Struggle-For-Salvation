class_name AbstractAbilityEffect
extends Resource


#var _wearer: Character


func get_description() -> String:
	return ""


func effect(character: Character = null, skill: Skill = null, dice: ActionDice = null) -> void:
	pass
