class_name ResistanceView
extends HBoxContainer


const _HIGH_HP_RESISTANCE_ICON: Texture2D = preload("res://sprites/ui/battle/popup_with_character_info/popup_with_character_base_info/resistances/hp/high_resistance_icon.svg")
const _LOW_HP_RESISTANCE_ICON: Texture2D = preload("res://sprites/ui/battle/popup_with_character_info/popup_with_character_base_info/resistances/hp/low_resistance_icon.svg")
const _HIGH_SP_RESISTANCE_ICON: Texture2D = preload("res://sprites/ui/battle/popup_with_character_info/popup_with_character_base_info/resistances/sp/high_resistance_icon.svg")
const _LOW_SP_RESISTANCE_ICON: Texture2D = preload("res://sprites/ui/battle/popup_with_character_info/popup_with_character_base_info/resistances/sp/low_resistance_icon.svg")

const _COLOR_BY_RESISTANCE_TYPE: Dictionary = {
	BaseResistance.ResistanceType.IMMUNITY : Color("000000"),
	BaseResistance.ResistanceType.INEFFECTIVE : Color("828282"),
	BaseResistance.ResistanceType.WEAK : Color("BABABA"),
	BaseResistance.ResistanceType.NORMAL : Color("F5F5F5"),
	BaseResistance.ResistanceType.HIGH : Color("D96B6B"),
	BaseResistance.ResistanceType.FATAL : Color("E04B4B")
}

@export var is_sp: bool = false

@onready var _icon: TextureRect = $Icon
@onready var _value_label: Label = $Value


func set_info(resistance: BaseResistance) -> void:
	var label_color: Color = _COLOR_BY_RESISTANCE_TYPE[resistance.resistance]
	_value_label.add_theme_color_override("font_color", label_color)
	_value_label.text = "[x%s]" % str(resistance.multiplier)
	if resistance.multiplier > 1.0:
		_icon.texture = _LOW_SP_RESISTANCE_ICON if is_sp else _LOW_HP_RESISTANCE_ICON
	else:
		_icon.texture = _HIGH_SP_RESISTANCE_ICON if is_sp else _HIGH_HP_RESISTANCE_ICON
