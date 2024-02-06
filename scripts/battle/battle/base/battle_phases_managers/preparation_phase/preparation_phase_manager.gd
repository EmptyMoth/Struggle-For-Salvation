class_name PreparationPhaseManager
extends Node


static func _on_battle_turn_started() -> void:
	AssaultLog.clear()
	GlobalParameters.get_tree().call_group(BattleGroups.CHARACTERS_GROUP, "prepare_character")
	await GlobalParameters.get_tree().process_frame
	AutoArrangeAssaults.arranges_enemies()
	PlayerState.switch_to_default()
	BattleSignals.preparation_started.emit()


static func finish_phase() -> void:
	AssaultsArrowsManager.clear_arrows()
	BattleSignals.preparation_ended.emit()
