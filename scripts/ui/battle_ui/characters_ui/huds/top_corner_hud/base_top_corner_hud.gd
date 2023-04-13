class_name BaseTopCornerHUD
extends AbstractHUD


const TIME_DURATION: float = 0.15

var fixed: bool = false

@onready var _main_element: MainElement = $TopCornerHUD/HUD/MainElement
@onready var _passive_ability_label: PassiveAbilityLabels = $TopCornerHUD/HUD/PassiveAbilityLabels
@onready var _card_container: MarginContainer = $TopCornerHUD/CardContainer


func _ready() -> void:
	bars = _main_element.get_burs()
	close()


func open(character: AbstractCharacter,
			speed_dice: AbstractSpeedDice = null) -> void:
	if not is_instance_valid(character):
		return
	set_character(character, speed_dice)
	_appear()


func close() -> void:
	if not fixed:
		_disappear()
		remove_card()


func set_character(character: AbstractCharacter, 
			speed_dice: AbstractSpeedDice = null) -> void:
	if not is_instance_valid(character):
		return
	if is_instance_valid(speed_dice):
		set_card(speed_dice.installed_card)
	
	bars.set_values_on_bars(character.physical_health, character.mental_health)
	_main_element.set_icon_character(character.icon)
	_main_element.set_resistaces(character.physical_resistance, character.mental_resistance)
	_passive_ability_label.set_passive_abilities(null)


func set_card(card: AbstractCard) -> void:
	if is_instance_valid(card):
		_card_container.add_child(card.create_duplicate_card())

func remove_card() -> void:
	for child in _card_container.get_children():
		_card_container.remove_child(child)


func toggle_pinned() -> void:
	if fixed:
		unpin()
	else:
		fix()


func fix() -> void:
	fixed = true


func unpin() -> void:
	fixed = false


func _appear() -> void:
	var tween: Tween = get_tree().create_tween()\
		.set_parallel(true)\
		.set_ease(Tween.EASE_IN)\
		.set_trans(Tween.TRANS_CUBIC)
	_change_display(tween, 0, 1)


func _disappear() -> void:
	var tween: Tween = get_tree().create_tween().set_parallel(true)
	_change_display(tween, -size.y, 0)


func _change_display(tween: Tween, new_position_y: float, modulate_alfa: float) -> void:
	tween.tween_property(self, "position:y", new_position_y, TIME_DURATION)
	tween.tween_property(self, "modulate:a", modulate_alfa, TIME_DURATION)
