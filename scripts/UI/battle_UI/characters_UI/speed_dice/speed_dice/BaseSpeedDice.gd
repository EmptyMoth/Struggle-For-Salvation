class_name BaseSpeedDice
extends Button


enum SpeedDiceState { 
	DEFAULT = 0,
	USED = 1, 
	BROKEN = 2, 
	INACTIVE = 3, 
}

var speed: int = 0
var current_state: SpeedDiceState = SpeedDiceState.DEFAULT
var is_select: bool = false

var installed_card: AbstractCard

@onready var _speed_value_label: Label = $SpeedValue
@onready var _states: TextureRect = $States


func _ready() -> void:
	_states.texture.current_frame = current_state


func set_speed(new_speed: int) -> void:
	speed = new_speed
	_speed_value_label.text = str(new_speed)


func _on_base_speed_dice_mouse_entered() -> void:
	is_select = true


func _on_base_speed_dice_mouse_exited() -> void:
	is_select = false
