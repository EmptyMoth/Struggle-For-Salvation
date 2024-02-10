class_name AbstractAbilityCondition
extends Resource


static func get_title() -> String:
	return "[b][color=#3af][%s][/color][/b]"  % _get_title()


static func _get_title() -> String:
	return ""


static func _get_condition(_owner: Character) -> Signal:
	return _owner.changed


func connect_condition(owner: Character, effect: Callable) -> void:
	_get_condition(owner).connect(effect)
