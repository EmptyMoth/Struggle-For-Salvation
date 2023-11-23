class_name SummationSkillType
extends AbstractSkillClashType


static func calculate_comparing_value(opponent_skill: AbstractSkill) -> int:
	var combat_skill: SkillCombatModel = opponent_skill.combat_model
	var summation_value: int = 0
	for i in range(combat_skill.get_index_current_dice(), combat_skill.dice_count):
		var action_dice: AbstractActionDice = combat_skill.get_dice_at(i)
		action_dice.values_model.roll_dice()
		summation_value += action_dice.values_model.get_current_value()
	return summation_value
