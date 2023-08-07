class_name EnemySpeedDice
extends AbstractSpeedDice


signal assault_is_scheduled(self_speed_dice: EnemySpeedDice)


func _ready() -> void:
	super._ready()
	
	#var arrow_of_assault = preload("res://scenes/ui/battle_ui/characters_ui/arrow_of_assault/static_arrow_of_assault/arrow_of_one_side_attack/ally_arrow_of_one_side_attack.tscn").instantiate()
	#_set_arrow_of_assault(arrow_of_assault)
	
	#self.was_selected.connect(PlayerState._on_enemy_speed_dice_was_selected)
	self.assault_is_scheduled.connect(
		HandlerForCardsPlacementByPlayer._on_enemy_speed_dice_assault_is_scheduled)


func _on_pressed() -> void:
	super._on_pressed()
	if PlayerState.current_player_state == PlayerState.PlayerStates.MANAGER:
		emit_signal("assault_is_scheduled", self)
