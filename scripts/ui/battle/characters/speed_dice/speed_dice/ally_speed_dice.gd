class_name AllySpeedDice
extends AbstractSpeedDice


signal was_selected(self_speed_dice: AllySpeedDice)
signal assault_was_canceled(self_speed_dice: AllySpeedDice)


var _arrow_of_player_assault: BaseArrowOfPlayerAssault = null


func _ready() -> void:
	super._ready()
	
	#var arrow_of_assault = preload("res://scenes/ui/battle_ui/characters_ui/arrow_of_assault/static_arrow_of_assault/arrow_of_one_side_attack/ally_arrow_of_one_side_attack.tscn").instantiate()
	#_set_arrow_of_assault(arrow_of_assault)


func _on_pressed() -> void:
	super._on_pressed()
	
	if Input.is_action_just_released("ui_pick"):
		emit_signal("was_selected", self)
	elif Input.is_action_just_released("ui_cancel"):
		if installed_skill:
			emit_signal("assault_was_canceled", self)
			remove_skill()
