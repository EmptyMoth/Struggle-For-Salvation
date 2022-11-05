class_name AbstractSpeedDice
extends Button


enum SpeedDiceState { 
	DEFAULT = 0,
	SELECTED = 1, 
	USED = 1, 
	BROKEN = 2, 
	INACTIVE = 3, 
}

var speed: int = 0
var current_state: SpeedDiceState = SpeedDiceState.DEFAULT

var installed_card: AbstractCard

@onready var _speed_value_label: Label = $States/SpeedValue
@onready var _states: TextureRect = $States


func _ready() -> void:
	_change_current_state(SpeedDiceState.DEFAULT)


func set_speed(new_speed: int) -> void:
	speed = new_speed
	_speed_value_label.text = str(new_speed)


func _change_current_state(new_state: SpeedDiceState) -> void:
	current_state = new_state
	_states.texture.current_frame = current_state


func _on_speed_dice_toggled(_button_pressed: bool) -> void:
	pass

	
func _on_speed_dice_mouse_entered() -> void:
	_change_current_state(SpeedDiceState.USED)


func _on_speed_dice_mouse_exited() -> void:
	_change_current_state(SpeedDiceState.DEFAULT)
