class_name AllySpeedDice
extends AbstractSpeedDice


func _on_speed_dice_toggled(_button_pressed: bool) -> void:
	CardPlacementManager.selected_ally_speed_dice = self


func _on_speed_dice_mouse_entered() -> void:
	super._on_speed_dice_mouse_entered()
	CardPlacementManager.selected_ally = get_character()
	CardPlacementManager.selected_ally_speed_dice = self


func _on_speed_dice_mouse_exited() -> void:
	super._on_speed_dice_mouse_exited()
	CardPlacementManager.selected_ally_speed_dice = null
	CardPlacementManager.selected_ally = null
