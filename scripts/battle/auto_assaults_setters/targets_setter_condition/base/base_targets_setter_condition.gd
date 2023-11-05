class_name BaseTargetsSetter
extends Resource


static func sorted_targets(targets_list: Array[Node]) -> Array[Node]:
	targets_list = targets_list.duplicate()
	targets_list.shuffle()
	return targets_list


static func choose_target_slot(target_slots: Array[ATPSlot]) -> ATPSlot:
	return target_slots.pick_random()
