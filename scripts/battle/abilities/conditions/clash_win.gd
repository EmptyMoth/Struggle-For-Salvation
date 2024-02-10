class_name ClashWinCondition
extends AbstractAbilityCondition


static func _get_title() -> String:
	return "Clash Win"


static func _get_condition(owner: Character) -> Signal:
	return owner.combat_model.won_clash
