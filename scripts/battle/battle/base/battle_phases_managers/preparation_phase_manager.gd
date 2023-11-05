class_name PreparationPhaseManager
extends RefCounted


static func _on_battle_started() -> void:
	BattleSignals.turn_started.emit()


static func _on_battle_turn_started() -> void:
	AssaultLog.clear()
	GlobalParameters.get_tree().call_group("characters", "roll_atp_slots")
	AutoArrangeAssaults.arranges_enemies()
	BattleSignals.preparation_started.emit()
