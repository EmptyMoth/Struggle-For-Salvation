class_name ClashWinCondition
extends AbstractAbilityCondition


static func _get_title() -> String:
	return "Clash Win"


func _get_condition(owner: Character) -> Signal:
	return owner.won_clash
