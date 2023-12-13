class_name PlayerState
extends RefCounted


enum PlayerStates { DEFAULT = 0, MANAGER = 1, OBSERVER = 2 }

static var _current_player_state: PlayerStates = PlayerStates.DEFAULT


static func is_default() -> bool: return _current_player_state == PlayerStates.DEFAULT

static func is_manager() -> bool: return _current_player_state == PlayerStates.MANAGER

static func is_observer_state() -> bool: return _current_player_state == PlayerStates.OBSERVER


static func switch_to_default() -> void: _current_player_state = PlayerStates.DEFAULT

static func switch_to_manager() -> void: _current_player_state = PlayerStates.MANAGER

static func switch_to_observer() -> void: _current_player_state = PlayerStates.OBSERVER
