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
	return 1 < get_potential_clashes(atp_slot).size()


static func get_assaults_by_speed() -> Dictionary:
	var assaults_by_speed: Dictionary = {}
	for atp_slot in _ASSAULTS_BY_ATP_SLOT:
		var assault: AssaultData = _ASSAULTS_BY_ATP_SLOT[atp_slot]
		assaults_by_speed[atp_slot.speed] = assaults_by_speed.get(atp_slot.speed, [])
		assaults_by_speed[atp_slot.speed].append(assault)
	
	return assaults_by_speed


static func add(assault: AssaultData) -> void:
	_ASSAULTS_BY_ATP_SLOT[assault.atp_slot] = assault
	var assaults_targeting: Array[AssaultData] = get_assaults_targeting(assault.targets.main)
	assaults_targeting.append(assault)
	_ASSAULTS_LIST_BY_TARGET_ATP_SLOT[assault.targets.main] = assaults_targeting
	AssaultsArrowsManager.create_arrows(assault)


static func add_clash(clash: AssaultData) -> void:
	if not clash.is_clash():
		return
		
	var potential_clashes: Array[AssaultData] = get_potential_clashes(clash.targets.main)
	potential_clashes.append(clash)
	_ASSAULTS_CAN_CLASH_LIST_BY_TARGET_ATP_SLOT[clash.targets.main] = potential_clashes


static func remove(atp_slot: ATPSlot) -> void:
	var assault: AssaultData = get_assault(atp_slot)
	if assault == null:
		return
	
	_ASSAULTS_BY_ATP_SLOT.erase(assault.atp_slot)
	get_assaults_targeting(assault.targets.main).erase(assault)
	get_potential_clashes(assault.targets.main).erase(assault)
	AssaultsArrowsManager.remove_arrows(assault)


static func clear() -> void:
	_ASSAULTS_BY_ATP_SLOT.clear()
	_ASSAULTS_LIST_BY_TARGET_ATP_SLOT.clear()
	_ASSAULTS_CAN_CLASH_LIST_BY_TARGET_ATP_SLOT.clear()
