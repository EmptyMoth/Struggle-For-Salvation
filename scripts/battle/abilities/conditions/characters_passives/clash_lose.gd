class_name ClashLoseCondition
extends AbstractCharacterAbilityCondition


static func _get_title() -> String:
	return "Clash Lose"


static func _get_condition(wearer: Character, _wearer_skill: Skill = null, _wearer_dice: ActionDice = null) -> Signal:
	return wearer.combat_model.lost_clash
