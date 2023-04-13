extends Node


var _ally_speed_dice: AllySpeedDice = null
var _enemy_speed_dice: EnemySpeedDice = null
var _current_card: AbstractCard = null


func _cancel() -> void:
	_ally_speed_dice = null
	_enemy_speed_dice = null
	_current_card = null
	PlayerState.switch_to_default_state()


func _on_ally_speed_dice_was_selected(
			ally_speed_dice: AllySpeedDice) -> void:
	if PlayerState.current_player_state == PlayerState.PlayerStates.DEFAULT:
		_ally_speed_dice = ally_speed_dice


func _on_ally_speed_dice_assault_was_canceled(
			ally_speed_dice: AllySpeedDice) -> void:
	CardPlacementManager.cancel_ally_assault(ally_speed_dice)


func _on_card_was_selected(card: AbstractCard) -> void:
	_current_card = card
	PlayerState.switch_to_manager_state()


func _on_enemy_speed_dice_assault_is_scheduled(
			enemy_speed_dice: EnemySpeedDice) -> void:
	_enemy_speed_dice = enemy_speed_dice
	_ally_speed_dice.set_card(_current_card)
	CardPlacementManager.set_assault(_ally_speed_dice, _enemy_speed_dice)
	_cancel()
