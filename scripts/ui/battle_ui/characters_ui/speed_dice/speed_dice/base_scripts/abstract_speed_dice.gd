class_name AbstractSpeedDice
extends Button


signal picked(self_speed_dice: AbstractSpeedDice)
signal selected(self_speed_dice: AbstractSpeedDice)
signal deselected(self_speed_dice: AbstractSpeedDice)


enum SpeedDiceState { 
	DEFAULT = 0,
	VIEWED = -1,
	SELECTED = -2, 
	USED = 1, 
	BROKEN = 2, 
	INACTIVE = 3, 
}

var speed: int = 0

var _current_state: SpeedDiceState = SpeedDiceState.DEFAULT
var current_state: SpeedDiceState :
	set(new_state):
		if new_state == SpeedDiceState.DEFAULT and is_assaulting():
			new_state = SpeedDiceState.USED
		_current_state = new_state
		if new_state >= 0:
			_states.texture.current_frame = new_state
	get:
		return _current_state

var installed_card: AbstractCard = null

@onready var _speed_value_label: Label = $States/SpeedValue
@onready var _border: TextureRect = $States/Border
@onready var _states: TextureRect = $States
@onready var _static_arrow_of_assault: BaseArrowOfOneSideAttack = null


func _ready() -> void:
	current_state = SpeedDiceState.DEFAULT


func _enter_tree() -> void:
	await get_tree().process_frame


static func calculate_assault_weight(
			character_speed_dice: AbstractSpeedDice, 
			opponent_speed_dice: AbstractSpeedDice,
			assault_type: int) -> int:
	return 10 * character_speed_dice.speed + assault_type


func is_assaulting() -> bool:
	return is_instance_valid(installed_card)


func make_default() -> void:
	current_state = SpeedDiceState.DEFAULT


func make_viewable() -> void:
	if current_state != SpeedDiceState.SELECTED:
		current_state = SpeedDiceState.VIEWED
		_border.show()

func cancel_viewable() -> void:
	if current_state != SpeedDiceState.SELECTED:
		make_default()
		_border.hide()


func make_selected() -> void:
	current_state = SpeedDiceState.SELECTED
	_border.show()

func cancel_selected() -> void:
	make_default()
	_border.hide()


func set_speed(new_speed: int) -> void:
	speed = new_speed
	_speed_value_label.text = str(new_speed)


func set_card(card: AbstractCard) -> void:
	if not is_instance_valid(card):
		return
	
	card.remaining_uses_count_in_turn -= 1
	installed_card = card
	current_state = SpeedDiceState.USED

func remove_card() -> void:
	installed_card = null
	current_state = SpeedDiceState.DEFAULT


func get_character() -> AbstractCharacter:
	return get_speed_dice_manager().get_character()


func get_speed_dice_manager() -> SpeedDiceManager:
	return get_parent().get_parent()


func _set_arrow_of_assault(arrow_of_assault: BaseArrowOfOneSideAttack) -> void:
	_static_arrow_of_assault = arrow_of_assault
	_static_arrow_of_assault.scale /= get_parent().scale
	add_child(_static_arrow_of_assault)
	#_static_arrow_of_assault.draw_arrow(Vector2(-1920/2, -1080/2))


func _on_speed_dice_toggled(_button_pressed: bool) -> void:
	if Input.is_action_just_released("ui_pick"):
		emit_signal("picked", self)

	
func _on_speed_dice_mouse_entered() -> void:
	make_viewable()
	emit_signal("selected", self)


func _on_speed_dice_mouse_exited() -> void:
	cancel_viewable()
	emit_signal("deselected", self)
