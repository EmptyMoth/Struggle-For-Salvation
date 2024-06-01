class_name TitlePassiveButton
extends BaseSelectButton


signal passive_picked(self_passive_button: TitlePassiveButton)
signal passive_selected(self_passive_button: TitlePassiveButton)
signal passive_deselected(self_passive_button: TitlePassiveButton)

var setted_passive: BaseCharacterAbility


func set_passive(passive: BaseCharacterAbility) -> void:
	setted_passive = passive
	text = setted_passive.passive_title


func get_tooltip_position_by_y() -> float:
	return global_position.y + size.y / 2.0


func _on_mouse_entered() -> void:
	passive_selected.emit(self)

func _on_mouse_exited() -> void:
	passive_deselected.emit(self)

func _on_toggled(toggled_on: bool) -> void:
	passive_picked.emit(self)
