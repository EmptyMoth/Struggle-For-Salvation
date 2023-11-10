class_name PreparationPhaseManager
extends RefCounted


static func _on_battle_turn_started() -> void:
	AssaultLog.clear()
	GlobalParameters.get_tree().call_group(BattleGroups.CHARACTERS_GROUP, "_on_battle_turn_started")
	AutoArrangeAssaults.arranges_enemies()
	BattleSignals.preparation_started.emit()


static func finish_phase() -> void:
	AssaultsArrowsManager.clear_arrows()
	BattleSignals.preparation_ended.emit()
