class_name IndividualSkillType
extends AbstractSkillClashType


static func calculate_comparing_value(opponent_skill: Skill) -> int:
	var current_dice: ActionDice = opponent_skill.combat_model.get_current_dice()
	current_dice.values_model.roll_dice()
	return current_dice.values_model.get_current_value()
