class_name CombatPhaseManager
extends Resource


static func _on_battle_preparation_ended() -> void:
	BattleSignals.combat_started.emit()
	var assaults: Array[AbstractAssault] = _get_sortet_assault()
	for assault in assaults:
		if assault.can_be_executed():
			assault.execute()
			await assault.executed
	BattleSignals.combat_ended.emit()


static func _get_sortet_assault() -> Array[AbstractAssault]:
	var assaults_data_by_speed: Dictionary = AssaultLog.get_assaults_data_by_speed()
	var speeds: Array = assaults_data_by_speed.keys()
	speeds.sort()
	speeds.reverse()
	var assaults: Array[AbstractAssault] = []
	for speed in speeds:
		assaults.append_array(assaults_data_by_speed[speed].map(
				func(data: AssaultData): return data.create_assault()))
	return assaults
