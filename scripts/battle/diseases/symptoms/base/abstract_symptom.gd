class_name AbstractSymptom
extends AbstractAbilityEffect


func get_title() -> String:
	return ""


func get_description() -> String:
	return ""


func effect(character: Character = null, skill: Skill = null, dice: ActionDice = null) -> void:
	pass
