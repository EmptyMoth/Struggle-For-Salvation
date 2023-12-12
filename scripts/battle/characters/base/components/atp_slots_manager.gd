class_name ATPSlotsManager
extends Resource


var wearer: Character
var atp_slots_count: int :
	get: return _atp_slots.size()

var _min_speed: int = 1
var _max_speed: int = 1
var _atp_slots: Array[ATPSlot] = []
var _atp_slots_container: ATPSlotsManagerUI


func _init(character: Character, atp_slots_container: ATPSlotsManagerUI) -> void:
	wearer = character
	_atp_slots_container = atp_slots_container
	_min_speed = character.stats.min_speed
	_max_speed = character.stats.max_speed
	change_atp_slots_count(character.stats.atp_slots_count)


func get_atp_slot(index: int) -> ATPSlot:
	return _atp_slots[index]

func get_all_atp_slots() -> Array[ATPSlot]:
	return _atp_slots.duplicate()

func get_atp_slots_for_assaults() -> Array[ATPSlot]:
	return _atp_slots.filter(func(atp_slot: ATPSlot) -> bool: 
				return not atp_slot.is_broken() and atp_slot.assaulting_skill == null)

func get_atp_slots_available_for_targeting() -> Array[ATPSlot]:
	return _atp_slots.filter(func(atp_slot: ATPSlot) -> bool: return not atp_slot.is_blocked())


func roll_atp_slots() -> void:
	var speeds: PackedInt32Array = _get_sorted_speed()
	for i: int in atp_slots_count:
		_atp_slots[i].speed = speeds[i]


func change_atp_slots_count(new_count: int) -> void:
	if new_count == atp_slots_count and new_count <= 0:
		return
	var difference: int = new_count - atp_slots_count
	if difference > 0:
		add_atp_slots(difference)
	else:
		remove_atp_slots(-difference)


func add_atp_slots(count: int) -> void:
	for i: int in count:
		var atp_slot: ATPSlot = ATPSlot.new(wearer)
		_atp_slots.append(atp_slot)
		_atp_slots_container.add_atp_slot(atp_slot.get_atp_slot_ui())


func remove_atp_slots(count: int) -> void:
	for i: int in count:
		var atp_slot: ATPSlot = _atp_slots.pop_back()
		_atp_slots_container.remove_atp_slot(atp_slot.get_atp_slot_ui())


func preparation_atp_slots() -> void:
	for atp_slot: ATPSlot in _atp_slots:
		atp_slot.remove_skill()


func _get_sorted_speed() -> PackedInt32Array:
	var speeds: PackedInt32Array = []
	for i: int in atp_slots_count:
		speeds.append(randi_range(_min_speed, _max_speed))
	
	speeds.sort()
	speeds.reverse()
	return speeds

