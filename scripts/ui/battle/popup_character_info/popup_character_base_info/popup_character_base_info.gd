class_name PopupCharacterBaseInfo
extends PanelContainer


@onready var _character_icon: TextureRect = $Margin/VBox/HBox/CharacterIcon/Icon
@onready var _character_type_icon: TextureRect = $Margin/VBox/HBox/VBox/Title/CharacterTypeIcon
@onready var _character_name_label: Label = $Margin/VBox/HBox/VBox/Title/CharacterName
@onready var _range_speed_label: Label = $Margin/VBox/HBox/VBox/MainContent/Speed/Range

@onready var _current_hp_count_label: Label = $Margin/VBox/HBox/VBox/MainContent/HP/Health/Counter/Current
@onready var _max_hp_count_label: Label = $Margin/VBox/HBox/VBox/MainContent/HP/Health/Counter/Max
@onready var _current_sp_count_label: Label = $Margin/VBox/HBox/VBox/MainContent/SP/Health/Counter/Current
@onready var _max_sp_count_label: Label = $Margin/VBox/HBox/VBox/MainContent/SP/Health/Counter/Max

@onready var _hp_resistance_view: ResistanceView = $Margin/VBox/HBox/VBox/MainContent/HP/Resistance
@onready var _sp_resistance_view: ResistanceView = $Margin/VBox/HBox/VBox/MainContent/SP/Resistance


func set_info(character: Character) -> void:
	_character_icon.texture = character.stats.icon
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
