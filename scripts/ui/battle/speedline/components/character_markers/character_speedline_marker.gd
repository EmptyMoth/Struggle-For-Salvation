extends MarginContainer


var _setted_character: Character
var _setted_atp_slot: ATPSlot

@onready var _character_icon: TextureButton = $Margin/Main/Character/Icon


func set_atp_slot(atp_slot: ATPSlot) -> void:
	_setted_character = atp_slot.wearer
	_character_icon.texture_normal = _setted_character.stats.speedline_icon
	_character_icon.flip_h = _setted_character.is_ally != Settings.gameplay_settings.allies_placement.is_left
	_setted_atp_slot = atp_slot
	var _atp_slot_ui: Control = atp_slot._atp_slot_ui.get_image_copy()
	_atp_slot_ui.scale = 40.0 / _atp_slot_ui.size.x * Vector2.ONE
	$APTSlot.add_child(_atp_slot_ui)
	_to_default()
	#$APTSlot.hide()


func _to_default() -> void:
	var tween: Tween = get_tree().create_tween().set_parallel()
	tween.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_OUT).tween_property($Margin, "theme_override_constants/margin_bottom", 12, 0.15)
	tween.tween_property($APTSlot, "modulate:a", 0.0, 0.15)
	tween.tween_property($APTSlot.get_child(0), "scale", 0.75 * Vector2.ONE, 0.15)
	#add_theme_constant_override("margin_bottom", 0)
	#$APTSlot.hide()

func _to_hover() -> void:
	var tween: Tween = get_tree().create_tween().set_parallel()
	tween.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_IN).tween_property($Margin, "theme_override_constants/margin_bottom", 35, 0.15)
	tween.tween_property($APTSlot, "modulate:a", 1.0, 0.15)
	tween.tween_property($APTSlot.get_child(0), "scale", Vector2.ONE, 0.15)
	#add_theme_constant_override("margin_bottom", 23)
	#$APTSlot.show()

func _to_press() -> void:
	pass


func _on_icon_draw() -> void:
	match _character_icon.get_draw_mode():
		BaseButton.DrawMode.DRAW_NORMAL:
			_to_default()
		BaseButton.DrawMode.DRAW_HOVER:
			_to_hover()
		BaseButton.DrawMode.DRAW_PRESSED:
			pass


func _on_icon_toggled(toggled_on: bool) -> void:
	if toggled_on:
		PlayerInputManager.get_character_picked_signal(_setted_character.is_ally).emit(_setted_character, _setted_atp_slot)

func _on_icon_mouse_entered() -> void:
	PlayerInputManager.get_character_selected_signal(_setted_character.is_ally).emit(_setted_character, _setted_atp_slot)

func _on_icon_mouse_exited() -> void:
	PlayerInputManager.get_character_deselected_signal(_setted_character.is_ally).emit(_setted_character, _setted_atp_slot)
