class_name AbstractAbilityEffect
extends Resource


#var _wearer: Character


func get_description() -> String:
	return ""


func effect(_character: Character = null, _skill: Skill = null, _dice: ActionDice = null) -> void:
	pass
