class_name ClashLoseCondition
extends AbstractAbilityCondition


static func _get_title() -> String:
	return "Clash Lose"


static func _get_condition(owner: Character) -> Signal:
	return owner.combat_model.lost_clash
