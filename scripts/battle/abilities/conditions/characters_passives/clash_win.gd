class_name ClashWinCondition
extends AbstractCharacterAbilityCondition


static func _get_title() -> String:
	return "Clash Win"


static func _get_condition(wearer: Character, _wearer_skill: Skill = null, _wearer_dice: ActionDice = null) -> Signal:
	return wearer.combat_model.won_clash
