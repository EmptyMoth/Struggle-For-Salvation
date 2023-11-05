class_name AbstractAbilityCondition
extends Resource


static func get_title() -> String:
	return "[b][color=#3af][%s][/color][/b]"  % _get_title()


static func _get_title() -> String:
	return ""


func connect_condition(owner: Character, effect: Callable) -> void:
	_get_condition(owner).connect(effect)


func _get_condition(_owner: Character) -> Signal:
	return self.changed
