class_name AllyATPSlot
extends AbstractATPSlot


func _on_atp_ui_pressed() -> void:
	#super()
	if PlayerState.is_default() \
			and installed_skill != null \
			and Input.is_action_just_released("ui_cancel"):
		emit_signal("assault_was_canceled", self)
		remove_skill()
