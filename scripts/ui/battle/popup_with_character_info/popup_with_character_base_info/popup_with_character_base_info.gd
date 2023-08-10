class_name PopupWithCharacterBaseInfo
extends PanelContainer


@onready var _character_icon: TextureRect = $Margin/VBox/MainInfo/HBox/CharacterIcon/Icon
@onready var _character_type_icon: TextureRect = $Margin/VBox/CharacterTitle/CharacterTypeIcon
@onready var _character_name_label: Label = $Margin/VBox/CharacterTitle/CharacterName
@onready var _range_speed_label: Label = $Margin/VBox/MainInfo/Speed/Range

@onready var _hp_resistance_icon: TextureRect = $Margin/VBox/MainInfo/HBox/Margin/Resistances/HPResistance
@onready var _sp_resistance_icon: TextureRect = $Margin/VBox/MainInfo/HBox/Margin/Resistances/SPResistance

@onready var _hp_bar: ProgressBar = $Margin/VBox/MainInfo/HBox/Healths/HP/Bar
@onready var _sp_bar: ProgressBar = $Margin/VBox/MainInfo/HBox/Healths/SP/Bar

@onready var _current_hp_count_label: Label = $Margin/VBox/MainInfo/HBox/Healths/HP/Margin/HBox/Counter/Current
@onready var _max_hp_count_label: Label = $Margin/VBox/MainInfo/HBox/Healths/HP/Margin/HBox/Counter/Max
@onready var _current_sp_count_label: Label = $Margin/VBox/MainInfo/HBox/Healths/SP/Margin/HBox/Counter/Current
@onready var _max_sp_count_label: Label = $Margin/VBox/MainInfo/HBox/Healths/SP/Margin/HBox/Counter/Max


func _ready() -> void:
	var character: AbstractCharacter = preload("res://scenes/battle/characters/immunocytes/neut.tscn").instantiate()
	add_child(character)
	set_info(character)


func set_info(character: AbstractCharacter) -> void:
	_character_icon.texture = character.icon
	_character_type_icon.texture.current_frame = character.stats.character_type
	_character_name_label.text = character.stats.character_name
	_range_speed_label.text = "%s-%s" % [character.stats.min_speed, character.stats.max_speed]
	_set_resistanes(character.physical_resistance, character.mental_resistance)
	_set_health(character.physical_health, character.mental_health)


func _set_resistanes(hp_resistance: BaseResistance, sp_resistance: BaseResistance) -> void:
	_hp_resistance_icon.texture.current_frame = hp_resistance.resistance
	_sp_resistance_icon.texture.current_frame = sp_resistance.resistance


func _set_health(hp: PhysicalHealth, sp: MentalHealth) -> void:
	_max_hp_count_label.text = str(hp.max_health)
	_current_hp_count_label.text = str(hp.current_health)
	_hp_bar.max_value = hp.max_health
	_hp_bar.value = hp.current_health
	
	_max_sp_count_label.text = str(sp.max_health)
	_current_sp_count_label.text = str(sp.current_health)
	_sp_bar.max_value = sp.max_health
	_sp_bar.value = sp.current_health
