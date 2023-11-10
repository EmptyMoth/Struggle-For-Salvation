class_name CombatPhaseManager
extends Resource


static func _on_battle_preparation_ended() -> void:
	BattleSignals.combat_started.emit()
	await implement_assaults()
	BattleSignals.combat_ended.emit()


static func implement_assaults() -> void:
	var assaults: Array[AbstractAssault] = AssaultLog.get_sorted_assault_by_speed()
	for assault in assaults:
		if not assault.can_be_executed():
			continue
		assault.execute()
		await assault.executed
