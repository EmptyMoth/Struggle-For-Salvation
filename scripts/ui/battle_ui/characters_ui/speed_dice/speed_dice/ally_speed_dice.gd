class_name AllySpeedDice
extends AbstractSpeedDice


signal was_selected(self_speed_dice: AllySpeedDice)
signal assault_was_canceled(self_speed_dice: AllySpeedDice)


var _arrow_of_player_assault: BaseArrowOfPlayerAssault = null


func _ready() -> void:
	super._ready()
	
	var arrow_of_assault = preload("res://scenes/ui/battle_ui/characters_ui/arrow_of_assault/arrow_of_player_assault/base_arrow_of_player_assault.tscn").instantiate()
	#var arrow_of_assault = preload("res://scenes/ui/battle_ui/characters_ui/arrow_of_assault/static_arrow_of_assault/arrow_of_one_side_attack/ally_arrow_of_one_side_attack.tscn").instantiate()
	_set_arrow_of_assault(arrow_of_assault)
	
	self.was_selected.connect(
		HandlerForCardsPlacementByPlayer._on_ally_speed_dice_was_selected)
	self.assault_was_canceled.connect(
		HandlerForCardsPlacementByPlayer._on_ally_speed_dice_assault_was_canceled)


func _on_pressed() -> void:
	super._on_pressed()
	
	if Input.is_action_just_released("ui_pick"):
		emit_signal("was_selected", self)
	elif Input.is_action_just_released("ui_cancel"):
		if is_instance_valid(installed_card):
			emit_signal("assault_was_canceled", self)
			remove_card()
