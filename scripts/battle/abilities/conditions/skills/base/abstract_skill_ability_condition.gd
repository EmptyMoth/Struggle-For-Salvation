class_name AbstractSkillAbilityCondition
extends AbstractAbilityCondition


static func _get_title() -> String:
	return super()


static func _get_condition(wearer: Character, wearer_skill: Skill, wearer_dice: ActionDice = null) -> Signal:
	return super(wearer, wearer_skill, wearer_dice)
