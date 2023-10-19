class_name AssaultSetter
extends RefCounted


static func set_assault(atp_slot: ATPSlot, skill: AbstractSkill, targets: Targets) -> void:
	var assault: AssaultData = AssaultLog.get_assault(atp_slot)
	if assault != null:
		remove_assault(atp_slot)
	assault = AssaultData.new(atp_slot, skill, targets)
	if _is_clash_assault(atp_slot, targets.main):
		_set_clash(assault, targets.main)
	AssaultLog.add(assault)


static func remove_assault(atp_slot: ATPSlot) -> void:
	var assault: AssaultData = AssaultLog.get_assault(atp_slot)
	AssaultLog.remove(assault.atp_slot)
	if assault.is_clash():
		_change_clash_or_default(AssaultLog.get_assault(assault.targets.main))


static func change_opponent_in_clash(atp_slot: ATPSlot) -> void:
	var clash: AssaultData = AssaultLog.get_assault(atp_slot)
	if not clash.is_clash():
		push_warning("change_opponent_in_clash for not clash")
		return

	var old_opponent_clash: AssaultData = AssaultLog.get_assault(clash.targets.main)
	var next_clash: AssaultData = AssaultLog.get_next_potential_clash(atp_slot)
	old_opponent_clash.set_default()
	_change_clash(clash, next_clash)


static func _is_clash_assault(character_atp_slot: ATPSlot, target_atp_slot: ATPSlot) -> bool:
	var target_assault: AssaultData = AssaultLog.get_assault(target_atp_slot)
	return target_assault != null \
			and (character_atp_slot.speed > target_atp_slot.speed \
			or target_assault.targets.main == character_atp_slot)


static func _set_clash(new_clash: AssaultData, opponent_atp_slot: ATPSlot) -> void:
	var opponent_assault: AssaultData = AssaultLog.get_assault(opponent_atp_slot)
	if opponent_assault.is_clash():
		_change_clash_or_default(AssaultLog.get_assault(opponent_assault.targets.main))
	_change_clash(new_clash, opponent_assault)


static func _change_clash_or_default(assault: AssaultData) -> void:
	var potential_clashes: Array[AssaultData] = AssaultLog.get_potential_clashes(assault.atp_slot)
	if AssaultLog.there_are_alternative_clash(assault.atp_slot):
		_change_clash(assault, AssaultLog.get_next_potential_clash(assault.atp_slot))
		return

	var old_targets: Targets = assault.targets.copy()
	assault.set_default()
	AssaultLog.change_assaults_targeting(assault, old_targets)


static func _change_clash(assault: AssaultData, mutable_assault: AssaultData) -> void:
	assault.set_clash(mutable_assault.atp_slot)
	var old_targets: Targets = mutable_assault.targets.copy()
	mutable_assault.set_clash(assault.atp_slot)
	AssaultLog.change_assaults_targeting(mutable_assault, old_targets)
