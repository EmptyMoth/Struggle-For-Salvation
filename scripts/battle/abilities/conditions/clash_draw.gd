class_name ClashDrawCondition
extends AbstractAbilityCondition


static func _get_title() -> String:
	return "Clash Draw"


func _get_condition(owner: Character) -> Signal:
	return owner.drew_clash
