class_name AbstractSpeedDice
extends Button


signal selected
signal deselected


enum SpeedDiceState { 
	DEFAULT = 0,
	SELECTED = 1, 
	USED = 1, 
	BROKEN = 2, 
	INACTIVE = 3, 
}

var speed: int = 0

var _current_state: SpeedDiceState = SpeedDiceState.DEFAULT
var current_state: SpeedDiceState :
	set(new_state):
		_current_state = new_state
		_states.texture.current_frame = new_state
	get:
		return _current_state

var installed_card: AbstractCard

@onready var _speed_value_label: Label = $States/SpeedValue
@onready var _states: TextureRect = $States


func _ready() -> void:
	current_state = SpeedDiceState.DEFAULT


func make_selected() -> void:
	current_state = SpeedDiceState.SELECTED


func cancel_selected() -> void:
	current_state = SpeedDiceState.DEFAULT


func set_speed(new_speed: int) -> void:
	speed = new_speed
	_speed_value_label.text = str(new_speed)


func get_character() -> AbstractCharacter:
	return get_speed_dice_manager().get_character()


func get_speed_dice_manager() -> SpeedDiceManager:
	return get_parent().get_parent()


func set_card(card: AbstractCard) -> void:
	if card != null:
		card.remaining_uses_count_in_turn -= 1
	installed_card = card


func _on_speed_dice_toggled(_button_pressed: bool) -> void:
#	if (Input.is_action_just_pressed("ui_cancel") && character.is_teammate):
#		character.is_character_selected = false
#		character.cancel_selected_card(self)
#		unpin_the_card()
#		BattleParameters.cancel_teammate_assault(self)
#		return
#
#	character.is_character_selected = !character.is_character_selected
#
#	if (character.is_teammate):
#		BattleParameters.set_selected_teammate(character, self)
#	else:
#		BattleParameters.set_selected_enemy(character, self)
#
#		BattleParameters.set_teammate_assault(self)
	pass

	
func _on_speed_dice_mouse_entered() -> void:
	current_state = SpeedDiceState.USED
	make_selected()
	emit_signal("selected")
#	_turn_on_selected()
#
#	if (character.is_teammate):
#		BattleParameters.put_teammate_on_view(self)
#	else:
#		BattleParameters.put_enemy_on_view(self)
#
#	if (_current_state == SpeedDiceState.BROKEN 
#			|| _current_state == SpeedDiceState.TURN_OFF
#			|| _current_state == SpeedDiceState.ROLE_VALUES):
#		return
#
#	character.show_elemets_character()
#	character.show_cards_in_hand(self)


func _on_speed_dice_mouse_exited() -> void:
	current_state = SpeedDiceState.DEFAULT
	cancel_selected()
	emit_signal("deselected")
#	if (!self.pressed):
#		_turn_off_selected()
#
#	if (character.is_teammate):
#		BattleParameters.remove_teammate_for_viewing(self)
#	else:
#		BattleParameters.remove_enemy_for_viewing(self)
#
#	if (_current_state == SpeedDiceState.BROKEN 
#			|| _current_state == SpeedDiceState.TURN_OFF
#			|| _current_state == SpeedDiceState.ROLE_VALUES):
#		return
#
#	character.hide_elemets_character()
#	character.hide_cards_in_hand(self)
