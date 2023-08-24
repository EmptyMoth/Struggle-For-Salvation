class_name ClashLoseCondition
extends AbstractAbilityCondition


static func _get_title() -> String:
	return "Clash Lose"


func _get_condition(owner: AbstractCharacter) -> Signal:
	return owner.lost_clash
