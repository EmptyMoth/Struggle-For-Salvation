class_name BaseTopCornerHUD
extends AbstractHUD


const TIME_DURATION: float = 0.15

var fixed: bool = false

@onready var _php_resistance_icon: TextureRect = $MainBackgroundStats/Resistances/PHPResistance
@onready var _mhp_resistance_icon: TextureRect = $MainBackgroundStats/Resistances/MHPResistance
@onready var _character_icon: TextureRect = $MainBackgroundStats/CharacterIcon
@onready var _passive_ability_label: PassiveAbilityLabels = $PassiveAbilityLabels


func _ready() -> void:
	bars = $MainBackgroundStats/TopCornerBars
	_disappear()


func set_character(character: AbstractCharacter) -> void:
	if not fixed:
		_appear()
	
	super.init(character.physical_health, character.mental_health)
	_set_resistaces(character.physical_resistance, character.mental_resistance)
	_set_icon_character(character.icon)
	_set_passive_abilities(null)


func close() -> void:
	if not fixed:
		_disappear()


func toggle_pinned() -> void:
	if fixed:
		unpin()
	else:
		fix()


func fix() -> void:
	fixed = true


func unpin() -> void:
	fixed = false


func _set_resistaces(
			physical_resistance: PhysicalResistance, 
			mental_resistance: MentalResistance) -> void:
	_php_resistance_icon.texture.current_frame = physical_resistance.resistance
	_mhp_resistance_icon.texture.current_frame = mental_resistance.resistance


func _set_icon_character(icon: CompressedTexture2D) -> void:
	if icon != null:
		_character_icon.texture = icon


func _set_passive_abilities(passive_abilities) -> void:
	_passive_ability_label.clear_passive_abilities()
	#_passive_ability_label.add_passive_abilities(passive_abilities)
	if _passive_ability_label.passive_abilities_count <= 0:
		return
		_passive_ability_label.hide()
	else:
		_passive_ability_label.show()


func _appear() -> void:
	if position.y < 0:
		var tween: Tween = get_tree().create_tween()\
			.set_parallel(true)\
			.set_ease(Tween.EASE_IN)\
			.set_trans(Tween.TRANS_CUBIC)
		_change_display(tween, 0, 1)


func _disappear() -> void:
	if position.y >= 0:
		var tween: Tween = get_tree().create_tween().set_parallel(true)
		_change_display(tween, -size.y, 0)


func _change_display(tween: Tween, new_position_y: float, modulate_alfa: float) -> void:
	tween.tween_property(self, "position:y", new_position_y, TIME_DURATION)
	tween.tween_property(self, "modulate:a", modulate_alfa, TIME_DURATION)
