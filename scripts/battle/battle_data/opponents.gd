class_name Opponents
extends Resource


var main: Character
var sub_targets: Array[Character] = []
var _targets: Targets


func _init(targets: Targets) -> void:
	_targets = targets
	main = targets.main.wearer
	for target: ATPSlot in targets.sub_targets:
		sub_targets.append(target.wearer)


func fast_init(main_opponents: Character, _sub_targets: Array[Character] = []) -> void:
	main = main_opponents
	sub_targets = _sub_targets


func copy() -> Opponents:
	return Opponents.new(_targets)


func get_all_opponents() -> Array[Character]:
	var targets: Array[Character] = [main]
	targets.append_array(sub_targets)
	return targets
