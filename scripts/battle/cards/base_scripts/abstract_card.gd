class_name AbstractCard
extends Node


@export var parameters: CardParameters = CardParameters.new()

#@onready var label_cooldown_time: Label = $Background/Counters/CooldownTime/Time
@onready var label_remaining_cooldown_time: Label = $RemainingCooldownTime
@onready var label_uses_count: Label = $Background/Counters/UsesCount/Count
@onready var background: TextureRect = $Background

var _remaining_cooldown_time: int = 0
var remaining_cooldown_time: int :
	set(value):
		_remaining_cooldown_time = value
		#if label_cooldown_time != null:
		#	label_cooldown_time.text = str(_remaining_cooldown_time)
	get:
		return _remaining_cooldown_time

var _remaining_uses_count_in_turn: int = parameters.uses_count_in_turn
var remaining_uses_count_in_turn: int :
	set(value):
		if value == 0:
			_remaining_uses_count_in_turn = 0
		elif parameters.cooldown_time == 0:
			_remaining_uses_count_in_turn = value
		else:
			_remaining_uses_count_in_turn = 1
		
		if label_uses_count != null:
			label_uses_count.text = str(_remaining_uses_count_in_turn)
	get:
		return _remaining_uses_count_in_turn


func _init() -> void:
	remaining_cooldown_time = 0
	remaining_uses_count_in_turn = parameters.uses_count_in_turn


func _ready() -> void:
	($Background/Name as Label).text = parameters.card_name
	($Background/Counters/CooldownTime/Time as Label).text = str(parameters.cooldown_time)
	#label_cooldown_time.text = str(_remaining_cooldown_time)
	label_remaining_cooldown_time.text = str(remaining_cooldown_time)
	label_remaining_cooldown_time.hide()
	label_uses_count.text = str(_remaining_uses_count_in_turn)


func _to_string() -> String:
	return parameters.card_name


func can_use() -> bool:
	return remaining_cooldown_time == 0 and remaining_uses_count_in_turn > 0


func leave_it_to_recharge() -> void:
	remaining_cooldown_time = parameters.cooldown_time
	if label_remaining_cooldown_time != null:
		label_remaining_cooldown_time.show()
		label_remaining_cooldown_time.text = str(remaining_cooldown_time)


func update() -> void:
	
	if background != null:
		background.modulate = Color(1, 1, 1) if can_use() else Color(0.55, 0.55, 0.55)
	
	remaining_uses_count_in_turn = parameters.uses_count_in_turn
	
	if remaining_cooldown_time > 0:
		remaining_cooldown_time -= 1
		if label_remaining_cooldown_time != null:
			label_remaining_cooldown_time.text = str(remaining_cooldown_time)
	else:
		if label_remaining_cooldown_time != null:
			label_remaining_cooldown_time.hide()
