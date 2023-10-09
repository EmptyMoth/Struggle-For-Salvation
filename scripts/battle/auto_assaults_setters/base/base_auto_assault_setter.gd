class_name BaseAutoAssaultSetter
extends Resource


static func choose_targets_atp_slot(
			targets_list: Array[Node], targets_count: int = 1) -> Targets:
	targets_list = _sorted_targets(targets_list.duplicate())
	var main_target: ATPSlot = _get_next_target_atp_slot(targets_list)
	if targets_count <= 1:
		return Targets.new(main_target)
	
	var sub_targets: Array[ATPSlot] = choose_sub_targets(targets_list, targets_count - 1)
	return Targets.new(main_target, sub_targets)


static func choose_sub_targets(
			targets_list: Array[Node], targets_count: int) -> Array[ATPSlot]:
	targets_list = targets_list.duplicate()
	var sub_targets: Array[ATPSlot] = []
	for i in targets_count:
		if targets_list.size() <= 0:
			break
		sub_targets.append(_get_next_target_atp_slot(targets_list))
	
	return sub_targets


static func _sorted_targets(targets_list: Array[Node]) -> Array:
	targets_list.shuffle()
	return targets_list


static func _choose_targets_atp_slot(target_atp_slots: Array[ATPSlot]) -> ATPSlot:
	return target_atp_slots.pick_random()


static func _get_next_target_atp_slot(targets_list: Array[Node]) -> ATPSlot:
	return _choose_targets_atp_slot(targets_list.pop_back().atp_slots_manager.get_all_atp_slots())
