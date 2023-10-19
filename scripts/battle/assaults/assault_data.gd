class_name AssaultData
extends Resource


var atp_slot: ATPSlot
var skill: AbstractSkill
var targets: Targets
var type: BattleEnums.AssaultType = BattleEnums.AssaultType.ONE_SIDE


func _init(_atp_slot: ATPSlot, _skill: AbstractSkill, _targets: Targets) -> void:
	atp_slot = _atp_slot
	skill = _skill
	targets = _targets


func _to_string() -> String:
	var result: String = "Clash %s<->%s" if is_clash() else "One-side %s->%s"
	return  result % [atp_slot.to_string(), targets.main.to_string()]


func is_clash() -> bool:
	return type == BattleEnums.AssaultType.CLASH

func is_one_side() -> bool:
	return type == BattleEnums.AssaultType.ONE_SIDE


func set_default() -> void:
	targets.set_default()
	type = BattleEnums.AssaultType.ONE_SIDE


func set_one_side() -> void:
	type = BattleEnums.AssaultType.ONE_SIDE


func set_clash(main_target: ATPSlot) -> void:
	targets.change_main_target(main_target)
	type = BattleEnums.AssaultType.CLASH


func can_assault() -> bool:
	return not atp_slot.wearer.is_stunned
