class_name OnHitDiceCondition
extends AbstractDiceAbilityCondition


static func _get_title() -> String:
	return "Clash Draw"


static func _get_condition(_wearer: Character, _wearer_skill: Skill, _wearer_dice: ActionDice) -> Signal:
	return _wearer_dice.property_list_changed
	#return (_wearer_dice.combat_model as OffensiveDice).hit
