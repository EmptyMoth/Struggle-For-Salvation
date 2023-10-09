class_name PlayerState
extends Node


enum PlayerStates { DEFAULT = 0, MANAGER = 1, OBSERVER = 2 }

static var _current_player_state: PlayerStates = PlayerStates.DEFAULT


static func is_default_state() -> bool:
	return _current_player_state == PlayerStates.DEFAULT

static func is_manager_state() -> bool:
	return _current_player_state == PlayerStates.MANAGER

static func is_observer_state() -> bool:
	return _current_player_state == PlayerStates.OBSERVER


static func switch_to_default_state() -> void:
	_current_player_state = PlayerStates.DEFAULT

static func switch_to_manager_state() -> void:
	_current_player_state = PlayerStates.MANAGER

static func switch_to_observer_state() -> void:
	_current_player_state = PlayerStates.OBSERVER


static func _on_enemy_speed_dice_was_selected() -> void:
	if _current_player_state == PlayerStates.MANAGER:
		_current_player_state = PlayerStates.DEFAULT
