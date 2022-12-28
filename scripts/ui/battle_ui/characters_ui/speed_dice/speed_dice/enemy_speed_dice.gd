class_name EnemySpeedDice
extends AbstractSpeedDice


func _on_speed_dice_toggled(_button_pressed: bool) -> void:
	CardPlacementManager.selected_enemy_speed_dice = self


func _on_speed_dice_mouse_entered() -> void:
	super._on_speed_dice_mouse_entered()
	CardPlacementManager.selected_enemy = get_character()
	CardPlacementManager.selected_enemy_speed_dice = self


func _on_speed_dice_mouse_exited() -> void:
	super._on_speed_dice_mouse_exited()
	CardPlacementManager.selected_enemy_speed_dice = null
	CardPlacementManager.selected_enemy = null
