class_name CombatPhaseManager
extends Node


static var assaults: Array[AssaultData]


static func _on_battle_preparation_ended() -> void:
	GlobalParameters.get_tree().call_group(BattleGroups.CHARACTERS_GROUP, "prepare_character_to_combat")
	await GlobalParameters.get_tree().process_frame
	BattleSignals.combat_started.emit()


static func _on_battle_combat_started() -> void:
	await _implement_assaults()
	BattleSignals.combat_ended.emit()


static func _implement_assaults() -> void:
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
