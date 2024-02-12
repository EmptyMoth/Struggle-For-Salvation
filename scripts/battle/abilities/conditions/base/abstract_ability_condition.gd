class_name AbstractAbilityCondition
extends Resource


static func get_title() -> String:
	return "[b][color=#3af][%s][/color][/b]"  % _get_title()


static func _get_title() -> String:
	return ""


static func _get_condition(wearer: Character, wearer_skill: Skill, wearer_dice: ActionDice) -> Signal:
	return wearer.changed


func connect_condition(effect: Callable, 
		wearer: Character, wearer_skill: Skill = null, wearer_dice: ActionDice = null) -> void:
	_get_condition(wearer, wearer_skill, wearer_dice).connect(effect)
