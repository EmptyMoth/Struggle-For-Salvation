class_name AssaultLog
extends RefCounted


static var _ASSAULTS_BY_ATP_SLOT: Dictionary = {}
static var _ASSAULTS_LIST_BY_TARGET_ATP_SLOT: Dictionary = {}
static var _ASSAULTS_CAN_CLASH_LIST_BY_TARGET_ATP_SLOT: Dictionary = {}


static func get_assault(atp_slot: ATPSlot) -> AssaultData:
	return _ASSAULTS_BY_ATP_SLOT.get(atp_slot) as AssaultData

static func get_assaults_targeting(target_atp_slot: ATPSlot) -> Array[AssaultData]:
	return _ASSAULTS_LIST_BY_TARGET_ATP_SLOT.get(target_atp_slot, [] as Array[AssaultData])

static func get_potential_clashes(target_atp_slot: ATPSlot) -> Array[AssaultData]:
	return _ASSAULTS_CAN_CLASH_LIST_BY_TARGET_ATP_SLOT.get(target_atp_slot, [] as Array[AssaultData])


static func there_are_alternative_clash(atp_slot: ATPSlot) -> bool:
	return get_potential_clashes(atp_slot).size() > 1

static func get_next_potential_clash(atp_slot: ATPSlot) -> AssaultData:
	var clash: AssaultData = get_assault(atp_slot)
	var old_opponent_clash: AssaultData = AssaultLog.get_assault(clash.targets.main)
	var potential_clashes: Array[AssaultData] = get_potential_clashes(atp_slot)
	var index_assault: int = potential_clashes.find(old_opponent_clash)
	var next_index_clash: int = (index_assault + 1) % potential_clashes.size()
	return potential_clashes[next_index_clash]


static func get_assaults_by_speed() -> Dictionary:
	var assaults_by_speed: Dictionary = {}
	for atp_slot in _ASSAULTS_BY_ATP_SLOT:
		var assault: AssaultData = _ASSAULTS_BY_ATP_SLOT[atp_slot]
		assaults_by_speed[atp_slot.speed] = assaults_by_speed.get(atp_slot.speed, [])
		assaults_by_speed[atp_slot.speed].append(assault)
	return assaults_by_speed


static func add(assault: AssaultData) -> void:
	_ASSAULTS_BY_ATP_SLOT[assault.atp_slot] = assault
	_add_assault_targeting(assault)
	if assault.is_clash():
		_add_potential_clash(assault)
	AssaultsArrowsManager.create_arrows(assault)


static func change_assaults_targeting(assault: AssaultData, old_target: Targets) -> void:
	get_assaults_targeting(old_target.main).erase(assault)
	for sub_target in old_target.sub_targets:
		get_assaults_targeting(sub_target).erase(assault)
	#_remove_assault_targeting(assault)
	_add_assault_targeting(assault)


static func remove(atp_slot: ATPSlot) -> void:
	var assault: AssaultData = get_assault(atp_slot)
	if assault == null:
		return
	
	_ASSAULTS_BY_ATP_SLOT.erase(assault.atp_slot)
	_remove_assault_targeting(assault)
	get_potential_clashes(assault.targets.main).erase(assault)
	AssaultsArrowsManager.remove_arrows(assault)
	atp_slot.remove_assault()


static func clear() -> void:
	_ASSAULTS_BY_ATP_SLOT.clear()
	_ASSAULTS_LIST_BY_TARGET_ATP_SLOT.clear()
	_ASSAULTS_CAN_CLASH_LIST_BY_TARGET_ATP_SLOT.clear()


static func _add_assault_targeting(assault: AssaultData) -> void:
	var assaults_targeting: Array[AssaultData] = get_assaults_targeting(assault.targets.main)
	assaults_targeting.append(assault)
	_ASSAULTS_LIST_BY_TARGET_ATP_SLOT[assault.targets.main] = assaults_targeting
	for sub_target in assault.targets.sub_targets:
		assaults_targeting = get_assaults_targeting(sub_target)
		assaults_targeting.append(assault)
		_ASSAULTS_LIST_BY_TARGET_ATP_SLOT[sub_target] = assaults_targeting

static func _remove_assault_targeting(assault: AssaultData) -> void:
	get_assaults_targeting(assault.targets.main).erase(assault)
	for sub_target in assault.targets.sub_targets:
		get_assaults_targeting(sub_target).erase(assault)

static func _add_potential_clash(assault: AssaultData) -> void:
	var potential_clashes: Array[AssaultData] = get_potential_clashes(assault.targets.main)
	potential_clashes.append(assault)
	_ASSAULTS_CAN_CLASH_LIST_BY_TARGET_ATP_SLOT[assault.targets.main] = potential_clashes
