class_name CombatPhaseManager
extends Resource


static func start() -> void:
	BattleSygnals.combat_started.emit()


static func make_assaults(assaults_by_speeds: Dictionary) -> void:
	var speeds_list: Array[int] = _get_sorted_speeds(assaults_by_speeds.keys())
	for speed in speeds_list:
		_execute_assaults(assaults_by_speeds[speed])


static func _get_sorted_speeds(speeds_list: Array[int]) -> Array[int]:
	speeds_list.sort()
	speeds_list.reverse()
	return speeds_list


static func _execute_assaults(assaults: Array[Assault]) -> void:
	for assault in assaults:
		if not assault.can_assault():
			continue
		assault.execute()
		await assault.executed
