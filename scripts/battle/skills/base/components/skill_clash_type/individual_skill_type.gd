class_name IndividualSkillType
extends AbstractSkillClashType


static func calculate_value_to_compare_in_clash(opponent_skill: SkillCombatModel) -> int:
	var current_dice: AbstractActionDice = opponent_skill.get_current_dice()
	current_dice.roll_dice()
	return current_dice.current_value
