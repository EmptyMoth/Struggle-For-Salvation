class_name MainElement
extends MarginContainer


@onready var _character_icon: TextureRect = $Stats/CharacterIcon
@onready var _bars: BaseContainerBars = $Stats/TopCornerBars
@onready var _php_resistance_icon: TextureRect = $Stats/Resistences/Resistences/PHPResistance
@onready var _mhp_resistance_icon: TextureRect = $Stats/Resistences/Resistences/MHPResistance


func get_burs() -> BaseContainerBars:
	return _bars


func set_icon_character(icon: CompressedTexture2D) -> void:
	if icon != null:
		_character_icon.texture = icon


func set_resistaces(
			physical_resistance: BaseResistance, 
			mental_resistance: BaseResistance) -> void:
	_php_resistance_icon.texture.current_frame = physical_resistance.resistance
	_mhp_resistance_icon.texture.current_frame = mental_resistance.resistance


