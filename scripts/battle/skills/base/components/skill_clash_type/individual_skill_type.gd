class_name IndividualSkillType
extends AbstractSkillClashType


static func calculate_comparing_value(opponent_skill: AbstractSkill) -> int:
	var current_dice: AbstractActionDice = opponent_skill.get_current_dice()
	current_dice.roll_dice()
	return current_dice.model.values_model.get_current_value()
