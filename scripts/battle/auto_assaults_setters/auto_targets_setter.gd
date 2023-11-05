class_name AutoTargetsSetter
extends Resource
 

static func choose_targets(
			targets_list: Array[Node], 
			targets_count: int = 1,
			targets_setter: BaseTargetsSetter = null) -> Targets:
	targets_list = (targets_setter if targets_setter else BaseTargetsSetter).sorted_targets(targets_list)
	var main_target: ATPSlot = _get_next_target_slot(targets_list, targets_setter)
	if targets_count <= 1:
		return Targets.new(main_target)
	var sub_targets: Array[ATPSlot] = _choose_sub_targets(
			targets_list, targets_count - 1, targets_setter)
	return Targets.new(main_target, sub_targets)


static func choose_sub_targets(
			targets_list: Array[Node], 
			targets_count: int,
			targets_setter: BaseTargetsSetter = null) -> Array[ATPSlot]:
	targets_list = (targets_setter if targets_setter else BaseTargetsSetter).sorted_targets(targets_list)
	return _choose_sub_targets(targets_list, targets_count, targets_setter)


static func _choose_sub_targets(
			targets_list: Array[Node], 
			targets_count: int, 
			targets_setter: BaseTargetsSetter = null) -> Array[ATPSlot]:
	var sub_targets: Array[ATPSlot] = []
	for i in min(targets_count, targets_list.size()):
		sub_targets.append(_get_next_target_slot(targets_list, targets_setter))
	return sub_targets


static func _get_next_target_slot(targets_list: Array[Node], 
			targets_setter: BaseTargetsSetter = null) -> ATPSlot:
	var targets_slots: Array[ATPSlot] = targets_list.pop_back().get_slots_available_for_targeting()
	return (targets_setter if targets_setter else BaseTargetsSetter).choose_target_slot(targets_slots)
