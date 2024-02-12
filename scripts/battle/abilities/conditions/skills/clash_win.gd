class_name ClashWinSkillCondition
extends AbstractSkillAbilityCondition


static func _get_title() -> String:
	return "Clash Win"


static func _get_condition(_wearer: Character, wearer_skill: Skill = null, _wearer_dice: ActionDice = null) -> Signal:
	return wearer_skill.changed
