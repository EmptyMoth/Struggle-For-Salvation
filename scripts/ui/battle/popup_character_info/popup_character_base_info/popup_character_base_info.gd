class_name PopupCharacterBaseInfo
extends PanelContainer


@export_group("Connections")
@export var button_hinding_passive: TextureButton

@export var _character_icon: TextureRect
@export var _character_type_icon: TextureRect
@export var _character_name_label: Label
@export var _range_speed_label: Label

@export var _current_hp_count_label: Label
@export var _max_hp_count_label: Label
@export var _current_sp_count_label: Label
@export var _max_sp_count_label: Label

@export var _hp_resistance_view: ResistanceView
@export var _sp_resistance_view: ResistanceView


func make_left() -> void:
	_character_icon.flip_h = false


func set_info(character: Character) -> void:
	_character_icon.texture = character.stats.panel_info_icon
	_character_type_icon.texture.current_frame = character.stats.type
	_character_name_label.text = character.stats.name
	_range_speed_label.text = "%s-%s" % [character.stats.min_speed, character.stats.max_speed]
	_set_resistanes(character.physical_resistance, character.mental_resistance)
	_set_health(character.physical_health, character.mental_health)


func _set_resistanes(hp_resistance: BaseResistance, sp_resistance: BaseResistance) -> void:
	_hp_resistance_view.set_info(hp_resistance)
	_sp_resistance_view.set_info(sp_resistance)


func _set_health(hp: BaseHealth, sp: BaseHealth) -> void:
	_max_hp_count_label.text = str(hp.max_health)
	_current_hp_count_label.text = str(hp.current_health)
	_max_sp_count_label.text = str(sp.max_health)
	_current_sp_count_label.text = str(sp.current_health)
