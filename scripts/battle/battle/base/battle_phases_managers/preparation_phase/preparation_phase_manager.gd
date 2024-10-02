class_name PreparationPhaseManager
extends Node


static var SORTED_ATP_SLOTS_BY_SPEED: Dictionary = {}


static func _on_battle_turn_started() -> void:
	AssaultLog.clear()
	PlayerState.switch_to_default()
	GlobalParameters.get_tree().call_group(BattleGroups.CHARACTERS_GROUP, "prepare_character")
	await GlobalParameters.get_tree().process_frame
	_sort_atp_slots_by_speed()
	AutoArrangeAssaults.arranges_enemies()
	BattleSignals.preparation_started.emit()


static func finish_phase() -> void:
	AssaultsArrowsManager.clear_arrows()
	BattleSignals.preparation_ended.emit()


static func _sort_atp_slots_by_speed() -> void:
	SORTED_ATP_SLOTS_BY_SPEED.clear()
	for atp_slot: BaseATPSlotUI in BattleGroups.get_all_atp_slots():
		var speed: int = atp_slot.model.speed
		var atp_slots: Array[ATPSlot] = SORTED_ATP_SLOTS_BY_SPEED.get(speed, [] as Array[ATPSlot])
		atp_slots.append(atp_slot.model)
		SORTED_ATP_SLOTS_BY_SPEED[speed] = atp_slots
