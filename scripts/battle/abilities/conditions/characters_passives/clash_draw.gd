class_name ClashDrawCondition
extends AbstractCharacterAbilityCondition


static func _get_title() -> String:
	return "Clash Draw"


static func _get_condition(wearer: Character, _wearer_skill: Skill = null, _wearer_dice: ActionDice = null) -> Signal:
	return wearer.combat_model.drew_clash
