class_name MentalHealth
extends AbstractHealth


signal stunned
signal came_out_of_stun

var _turn_count_in_stun: int = 0 :
	set(new_turn_count):
		_turn_count_in_stun = new_turn_count
		if _turn_count_in_stun <= 0:
			reset()
			came_out_of_stun.emit()


func _init(max_value: int) -> void:
	super(max_value)
	BattleSignals.turn_ended.connect(_battle_turn_ended)


func get_out_of_stun() -> void:
	if is_empty():
		_turn_count_in_stun = 0


func _reached_zero() -> void:
	super()
	stunned.emit()
	_turn_count_in_stun = 2


func _battle_turn_ended() -> void:
	if is_empty():
		_turn_count_in_stun -= 1
