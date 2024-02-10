class_name TurnStartCondition
extends AbstractAbilityCondition


static func _get_title() -> String:
	return "Turn Start"


static func _get_condition(wearer: Character) -> Signal:
	return BattleSignals.turn_started

