class_name PreparationPhaseManager
extends RefCounted


static func _on_battle_started() -> void:
	BattleSignals.turn_started.emit()


static func _on_battle_turn_started() -> void:
	AssaultLog.clear()
	GlobalParameters.get_tree().call_group("characters", "roll_atp_slots")
	auto_arranges_enemies_assaults()
	BattleSignals.preparation_started.emit()


static func auto_arranges_enemies_assaults() -> void:
	var enemies: Array[Node] = GlobalParameters.get_nodes_in_group(
			BattleParameters.CHARACTERS_GROUPS_BY_FRACTIONS[BattleEnums.Fraction.ENEMY])
	var allies: Array[Node] = GlobalParameters.get_nodes_in_group(
			BattleParameters.CHARACTERS_GROUPS_BY_FRACTIONS[BattleEnums.Fraction.ALLY])
	_auto_arranges_characters_assaults(enemies, allies)


static func auto_arranges_allies_assaults() -> void:
	var allies: Array[Node] = GlobalParameters.get_nodes_in_group(
			BattleParameters.CHARACTERS_GROUPS_BY_FRACTIONS[BattleEnums.Fraction.ALLY])
	var enemies: Array[Node] = GlobalParameters.get_nodes_in_group(
			BattleParameters.CHARACTERS_GROUPS_BY_FRACTIONS[BattleEnums.Fraction.ENEMY])
	_auto_arranges_characters_assaults(allies, enemies)


static func set_assault(atp_slot: ATPSlot, targets: Targets) -> void:
	var assault: Assault = AssaultLog.get_assault(atp_slot)
	if assault == null:
		assault = Assault.new(atp_slot, targets)
	else:
		AssaultLog.remove(atp_slot)
	
	AssaultLog.add(assault)
	if _is_clash_assault(atp_slot, targets.main):
		_set_clash(atp_slot, targets.main)
		return
	_set_one_side(atp_slot, targets.main)


static func remove_assault(atp_slot: ATPSlot) -> void:
	var assault: Assault = AssaultLog.get_assault(atp_slot)
	AssaultLog.remove(atp_slot)
	if assault.is_clash():
		_change_clash_or_default(assault.targets.main)


static func change_opponent_in_clash(atp_slot: ATPSlot) -> void:
	var assault: Assault = AssaultLog.get_assault(atp_slot)
	if not assault.is_clash():
		push_warning("change_opponent_in_clash for not assault")
		return
	
	var opponent_assault: Assault = AssaultLog.get_assault(assault.targets.main)
	var potential_clashes: Array[Assault] = AssaultLog.get_potential_clashes(atp_slot)
	var index_assault: int = potential_clashes.find(opponent_assault)
	var next_index_assault: int = (index_assault + 1) % potential_clashes.size()
	var next_assault: Assault = potential_clashes[next_index_assault]
	_set_one_side(opponent_assault.atp_slot, assault.atp_slot)
	_change_clash(assault, next_assault)


static func _is_clash_assault(character_atp_slot: ATPSlot, target_atp_slot: ATPSlot) -> bool:
	var target_assault: Assault = AssaultLog.get_assault(target_atp_slot)
	return target_assault != null \
			and (character_atp_slot.speed > target_atp_slot.speed \
			or target_assault.targets.main == character_atp_slot)


static func _set_one_side(atp_slot: ATPSlot, target_atp_slot: ATPSlot) -> void:
	AssaultLog.get_assault(atp_slot).set_one_side(target_atp_slot)

static func _set_clash(atp_slot: ATPSlot, opponent_atp_slot: ATPSlot) -> void:
	var opponent_assault: Assault = AssaultLog.get_assault(opponent_atp_slot)
	if opponent_assault.is_clash():
		AssaultLog.get_assault(opponent_assault.targets.main).set_one_side(opponent_atp_slot)
	
	var new_clash: Assault = AssaultLog.get_assault(atp_slot)
	_change_clash(new_clash, opponent_assault)
	AssaultLog.add_clash(new_clash)


static func _change_clash_or_default(atp_slot: ATPSlot) -> void:
	var potential_clashes: Array[Assault] = AssaultLog.get_potential_clashes(atp_slot)
	if potential_clashes.size() > 0:
		_change_clash(AssaultLog.get_assault(atp_slot), potential_clashes.back())
		return
	AssaultLog.get_assault(atp_slot).set_default()


static func _change_clash(assault: Assault, new_assault_for_clash: Assault) -> void:
	assault.set_clash(new_assault_for_clash.atp_slot)
	new_assault_for_clash.set_clash(assault.atp_slot)


static func _auto_arranges_characters_assaults(
		characters: Array[Node], opponents: Array[Node]) -> void:
	for character in characters:
		var targets_by_atp_slots: Dictionary = character.auto_selecting_assault(opponents)
		for atp_slot in targets_by_atp_slots:
			var targets: Targets = targets_by_atp_slots[atp_slot]
			set_assault(atp_slot, targets)
