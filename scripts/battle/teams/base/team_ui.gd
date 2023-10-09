class_name TeamUI
extends Resource


var selected_character: Character = null :
	set(character):
		if is_instance_valid(selected_character):
			selected_character.get_view().cancel_selected()
		selected_character = character
		if character != null:
			character.get_view().make_selected()
var selected_atp_slot: ATPSlot = null :
	set(atp_slot):
		if selected_atp_slot != null:
			selected_atp_slot.get_atp_slot_ui().deselected()
		selected_atp_slot = atp_slot

var popup_with_character_info: BasePopupWithCharacterInfo = null


func is_character_selected() -> bool:
	return selected_character != null


func is_same_selected(character: Character, atp_slot: ATPSlot = null) -> bool:
	return selected_character == character and selected_atp_slot == atp_slot


func set_selected_character_info() -> void:
	set_character_info(selected_character, selected_atp_slot)

func set_character_info(character: Character, atp_slot: ATPSlot) -> void:
	popup_with_character_info.set_info(character, atp_slot)


func select_character(character: Character, atp_slot: ATPSlot = null) -> void:
	selected_character = character
	selected_atp_slot = atp_slot


func deselect_character() -> void:
	selected_atp_slot = null
	selected_character = null


func close_ui() -> void:
	deselect_character()
	popup_with_character_info.close()


func connect_signals(character: CharacterView) -> void:
	character.picked.connect(_on_character_picked)
	character.selected.connect(_on_character_selected)
	character.deselected.connect(_on_character_deselected)


func _on_character_picked(character: Character, atp_slot: ATPSlot = null) -> void:
	if is_same_selected(character, atp_slot):
		deselect_character()
	else:
		select_character(character, atp_slot)


func _on_character_selected(character: Character, atp_slot: ATPSlot = null) -> void:
	set_character_info(character, atp_slot)


func _on_character_deselected(_character: Character, _atp_slot: ATPSlot = null) -> void:
	if is_character_selected():
		set_selected_character_info()
	else:
		close_ui()
