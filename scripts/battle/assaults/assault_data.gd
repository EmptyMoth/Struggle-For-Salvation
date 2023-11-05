class_name AssaultData
extends Resource


signal assault_data_changed(changed_assault: AssaultData, old_targets: Targets)

var atp_slot: ATPSlot
var targets: Targets
var type: BattleEnums.AssaultType = BattleEnums.AssaultType.ONE_SIDE


func _init(_atp_slot: ATPSlot,  _targets: Targets) -> void:
	atp_slot = _atp_slot
	targets = _targets


func _to_string() -> String:
	var result: String = "%s<->%s" if is_clash() else "%s->%s"
	return  result % [atp_slot.to_string(), targets.main.to_string()]


func is_clash() -> bool:
	return type == BattleEnums.AssaultType.CLASH

func is_one_side() -> bool:
	return type == BattleEnums.AssaultType.ONE_SIDE


func set_default() -> void:
	var old_main_target: Targets = targets.copy()
	targets.set_default()
	type = BattleEnums.AssaultType.ONE_SIDE
	assault_data_changed.emit(self, old_main_target)


func set_clash(main_target: ATPSlot) -> void:
	var old_main_target: Targets = targets.copy()
	targets.change_main_target(main_target)
	type = BattleEnums.AssaultType.CLASH
	assault_data_changed.emit(self, old_main_target)
