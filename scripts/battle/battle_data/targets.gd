class_name Targets
extends Node


var main: ATPSlot
var sub_targets: Array[ATPSlot]

var _default_main: ATPSlot


func _init(main_target: ATPSlot, sub_targets_list: Array[ATPSlot] = []) -> void:
	_default_main = main_target
	main = _default_main
	sub_targets = sub_targets_list


func set_default() -> void:
	if main == _default_main:
		return
	
	if main in sub_targets:
		sub_targets.append(main)
		sub_targets.erase(_default_main)
	main = _default_main


func change_main_target(new_target: ATPSlot) -> void:
	if new_target == main:
		return
	
	set_default()
	if new_target in sub_targets:
		sub_targets.erase(new_target)
		sub_targets.append(main)
	main = new_target
