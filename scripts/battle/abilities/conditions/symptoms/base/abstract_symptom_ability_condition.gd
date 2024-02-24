class_name AbstractSymptomAbilityCondition
extends AbstractAbilityCondition


static func _get_title() -> String:
	return super()


static func _get_condition(wearer: Character = null, wearer_skill: Skill = null, wearer_dice: ActionDice = null) -> Signal:
	return super(wearer, wearer_skill, wearer_dice)
