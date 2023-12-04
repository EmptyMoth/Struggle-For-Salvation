class_name AssaultData
extends Resource


signal assault_data_changed(changed_assault: AssaultData)

var atp_slot: ATPSlot
var targets: Targets
var type: BattleEnums.AssaultType = BattleEnums.AssaultType.ONE_SIDE

var character: Character :
	get: return atp_slot.wearer
var main_target: Character :
	get: return targets.main.wearer


func _init(_atp_slot: ATPSlot,  _targets: Targets) -> void:
	atp_slot = _atp_slot
	targets = _targets


func _to_string() -> String:
	var result: String = "%s<->%s" if is_clash() else "%s->%s"
	return  result % [atp_slot.to_string(), targets.main.to_string()]


#func create_assault() -> AbstractAssault:
#	if is_clash():
#		var clash: ClashAssault = ClashAssault.new(self)
#		if clash.can_be_executed():
#			return clash
#	return OneSideAssault.new(self)


func is_clash() -> bool:
	return type == BattleEnums.AssaultType.CLASH

func is_one_side() -> bool:
	return type == BattleEnums.AssaultType.ONE_SIDE


func set_default() -> void:
	targets.set_default()
	type = BattleEnums.AssaultType.ONE_SIDE
	assault_data_changed.emit(self)


func set_clash(new_main_target: ATPSlot) -> void:
	targets.change_main_target(new_main_target)
	type = BattleEnums.AssaultType.CLASH
	assault_data_changed.emit(self)
