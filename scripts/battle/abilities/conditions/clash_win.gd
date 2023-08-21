class_name ClashWinCondition
extends AbstractAbilityCondition


static func _get_title() -> String:
	return "Clash Win"


func _get_condition(owner: AbstractCharacter) -> Signal:
	return owner.clash_win
