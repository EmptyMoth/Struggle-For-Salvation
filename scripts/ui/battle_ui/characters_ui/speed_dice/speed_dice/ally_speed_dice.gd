class_name AllySpeedDice
extends AbstractSpeedDice


func _on_speed_dice_toggled(_button_pressed: bool) -> void:
	CardPlacementManager.selected_ally_speed_dice = self

func _on_speed_dice_mouse_entered() -> void:
	pass
	#CardPlacementManager.selected_ally_speed_dice = self
