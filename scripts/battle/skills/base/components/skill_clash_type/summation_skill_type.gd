class_name SummationSkillType
extends AbstractSkillClashType


static func calculate_comparing_value(opponent_skill: SkillCombatModel) -> int:
	var summation_value: int = 0
	for i in range(opponent_skill.get_index_current_dice(), opponent_skill.dice_count):
		var action_dice: ActionDiceCombatModel = opponent_skill.get_dice_at(i)
		action_dice.roll_dice()
		summation_value += action_dice.model.values_model.get_current_value()
	return summation_value
