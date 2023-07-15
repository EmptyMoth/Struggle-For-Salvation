extends Node


signal set_assault


enum PlayerStates { DEFAULT, MANAGER, OBSERVER }

var current_player_state: PlayerStates = PlayerStates.DEFAULT


func switch_to_manager_state() -> void:
	current_player_state = PlayerStates.MANAGER

func switch_to_default_state() -> void:
	current_player_state = PlayerStates.DEFAULT

func switch_to_observer_state() -> void:
	current_player_state = PlayerStates.OBSERVER


func _on_enemy_speed_dice_was_selected() -> void:
	if current_player_state == PlayerStates.MANAGER:
		#emit_signal("set_assault")
		current_player_state = PlayerStates.DEFAULT
