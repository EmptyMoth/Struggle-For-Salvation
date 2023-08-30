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
		_current_state = new_state
		_states.texture.current_frame = max(0, new_state)
	get:
		return _current_state

var wearer: AbstractCharacter
var installed_skill: AbstractSkill = null

@onready var _speed_value_label: Label = $States/SpeedValue
@onready var _border: TextureRect = $States/Border
@onready var _states: TextureRect = $States
@onready var _static_arrow_of_assault: BaseArrowOfOneSideAttack = null


func _ready() -> void:
	current_state = SpeedDiceState.DEFAULT


static func calculate_assault_weight(
			character_speed_dice: AbstractSpeedDice, 
			_opponent_speed_dice: AbstractSpeedDice,
			assault_type: int) -> int:
	return 10 * character_speed_dice.speed + assault_type


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


func set_skill(skill: AbstractSkill) -> void:
	installed_skill = skill
	current_state = SpeedDiceState.USED

func remove_skill() -> void:
	installed_skill = null
	current_state = SpeedDiceState.DEFAULT


func get_character() -> AbstractCharacter:
	return get_speed_dice_manager().get_character()


func get_speed_dice_manager() -> SpeedDiceManager:
	return get_parent().get_parent()


func _set_arrow_of_assault(arrow_of_assault: BaseArrowOfOneSideAttack) -> void:
	_static_arrow_of_assault = arrow_of_assault
	_static_arrow_of_assault.scale /= get_parent().scale
	_static_arrow_of_assault.position = get_size() / 2
	add_child(_static_arrow_of_assault)
	#_static_arrow_of_assault.draw_arrow(Vector2(-1920/2, -1080/2))


func _on_pressed() -> void:
	if Input.is_action_just_released("ui_pick"):
		emit_signal("picked", self)


func _on_mouse_entered() -> void:
	make_viewable()
	emit_signal("selected", self)


func _on_mouse_exited() -> void:
	cancel_viewable()
	emit_signal("deselected", self)
