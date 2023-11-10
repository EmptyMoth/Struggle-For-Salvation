class_name SummationSkillType
extends AbstractSkillClashType


static func calculate_value_to_compare_in_clash(opponent_skill: SkillCombatModel) -> int:
	var summation_value: int = 0
	for i in range(opponent_skill.get_index_current_dice(), opponent_skill.dice_count):
		var action_dice: AbstractActionDice = opponent_skill.get_dice_at(i)
		action_dice.roll_dice()
		summation_value += action_dice.current_value
	return summation_value
