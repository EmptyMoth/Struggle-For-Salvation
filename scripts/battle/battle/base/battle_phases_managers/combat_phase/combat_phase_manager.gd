class_name CombatPhaseManager
extends Resource


static var assaults: Array[AssaultData]


static func _on_battle_preparation_ended() -> void:
	BattleSignals.combat_started.emit()
	await implement_assaults()
	BattleSignals.combat_ended.emit()


static func implement_assaults() -> void:
	assaults = AssaultLog.get_sorted_assault_by_speed()
	while assaults.size() > 0:
		var assault_data: AssaultData = assaults.pop_back()
		if assault_data.type == BattleEnums.AssaultType.CLASH \
				and ClashAssault.can_be_executed(assault_data):
			var opponent_assault_data: AssaultData = AssaultLog.get_assault(assault_data.targets.main)
			assaults.erase(opponent_assault_data)
			await ClashAssault.new(assault_data, opponent_assault_data).execute()
		elif OneSideAssault.can_be_executed(assault_data):
			await OneSideAssault.new(assault_data).execute()
