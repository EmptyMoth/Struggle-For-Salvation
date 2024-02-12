class_name TurnStartCondition
extends AbstractCharacterAbilityCondition


static func _get_title() -> String:
	return "Turn Start"


static func _get_condition(_wearer: Character, _wearer_skill: Skill = null, _wearer_dice: ActionDice = null) -> Signal:
	return BattleSignals.turn_started

