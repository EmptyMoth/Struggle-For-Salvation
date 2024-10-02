class_name TeamUI
extends Resource


var selected_character: Character = null :
	set(character):
		if selected_character != null:
			selected_character.view_model.cancel_selected()
		selected_character = character
		if character != null:
			character.view_model.make_selected()
var selected_atp_slot: ATPSlot = null :
	set(atp_slot):
		if selected_atp_slot != null:
			AssaultsArrowsManager.toggle_arrows_by_atp_slot(selected_atp_slot, false)
			AssaultsArrowsManager.hide_arrows_by_atp_slot(selected_atp_slot)
			selected_atp_slot.get_atp_slot_ui().deselected()
		if atp_slot != null:
			AssaultsArrowsManager.toggle_arrows_by_atp_slot(atp_slot, true)
		selected_atp_slot = atp_slot

var _popup_with_character_info: PopupWithCharacterInfo = null

var _tooltip_skill_set: TooltipSkillsSet = preload("res://scenes/ui/battle/tooltips/tooltip_skills_set.tscn").instantiate()


func is_character_selected() -> bool:
	return selected_character != null


func is_same_selected(character: Character, atp_slot: ATPSlot = null) -> bool:
	return selected_character == character and selected_atp_slot == atp_slot


func set_selected_character_info() -> void:
	set_character_info(selected_character, selected_atp_slot)

func set_character_info(character: Character, atp_slot: ATPSlot) -> void:
	_popup_with_character_info.set_info(character, atp_slot)


func select_character(character: Character, atp_slot: ATPSlot = null) -> void:
	selected_character = character
	selected_atp_slot = atp_slot


func deselect_character() -> void:
	selected_atp_slot = null
	selected_character = null


func close_ui() -> void:
	deselect_character()
	_popup_with_character_info.close()
	_tooltip_skill_set.hide()


func set_team_ui(popup: PopupWithCharacterInfo, tooltip: TooltipSkillsSet) -> void:
	_popup_with_character_info = popup
	_tooltip_skill_set = tooltip


func connect_signals(team_fraction: BattleEnums.Fraction) -> void:
	PlayerInputManager.player_made_general_cancel.connect(close_ui)
	var is_ally: bool = team_fraction == BattleEnums.Fraction.ALLY
	PlayerInputManager.get_character_picked_signal(is_ally).connect(_on_character_picked)
	PlayerInputManager.get_character_selected_signal(is_ally).connect(_on_character_selected)
	PlayerInputManager.get_character_deselected_signal(is_ally).connect(_on_character_deselected)
	
	_tooltip_skill_set.skill_picked.connect(_popup_with_character_info._on_skill_button_picked)
	_tooltip_skill_set.skill_selected.connect(_popup_with_character_info._on_skill_button_selected)
	_tooltip_skill_set.skill_deselected.connect(_popup_with_character_info._on_skill_button_deselected)


func _setup_skills_tooltip(character: Character, atp_slot: ATPSlot) -> void:
	_tooltip_skill_set.func_get_position = func(): return atp_slot.get_atp_slot_ui().get_screen_position() + Vector2(atp_slot.get_atp_slot_ui().size.x/2, 0)
	_tooltip_skill_set.set_skills(character.skills_manager.get_all_skills())
	_tooltip_skill_set.show()


func _on_character_picked(character: Character, atp_slot: ATPSlot = null) -> void:
	if is_same_selected(character, atp_slot):
		deselect_character()
		_tooltip_skill_set.is_fixed = false
	else:
		select_character(character, atp_slot)
		if atp_slot != null:
			_tooltip_skill_set.is_fixed = true


func _on_character_selected(character: Character, atp_slot: ATPSlot = null) -> void:
	set_character_info(character, atp_slot)
	if atp_slot != null:
		_setup_skills_tooltip(character, atp_slot)
		_tooltip_skill_set.show()
		AssaultsArrowsManager.show_arrows_by_atp_slot(atp_slot)


func _on_character_deselected(_character: Character, _atp_slot: ATPSlot = null) -> void:
	if _atp_slot != null:
		AssaultsArrowsManager.hide_arrows_by_atp_slot(_atp_slot)
	
	if is_character_selected():
		set_selected_character_info()
		_setup_skills_tooltip(selected_character, selected_atp_slot)
	else:
		close_ui()
