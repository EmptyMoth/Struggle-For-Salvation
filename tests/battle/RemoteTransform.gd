extends RemoteTransform2D


@onready var character: AbstractCharacter = get_node(remote_path)


func _on_stand_pressed() -> void: 
	get_tree().call_group("characters", "actions_switcher", BattleParameters.Action.DEFAULT)
	#character.actions_switcher(BattleParameters.Action.DEFAULT)

func _on_movement_pressed() -> void:
	get_tree().call_group("characters", "actions_switcher", BattleParameters.Action.MOVEMENT)
	#character.actions_switcher(BattleParameters.Action.MOVEMENT)

func _on_stunning_pressed() -> void:
	get_tree().call_group("characters", "actions_switcher", BattleParameters.Action.STUN)
	#character.actions_switcher(BattleParameters.Action.STUN)

func _on_block_pressed() -> void:
	get_tree().call_group("characters", "actions_switcher", BattleParameters.Action.BLOCK)
	#character.actions_switcher(BattleParameters.Action.BLOCK)

func _on_evade_pressed() -> void:
	get_tree().call_group("characters", "actions_switcher", BattleParameters.Action.EVADE)
	#character.actions_switcher(BattleParameters.Action.EVADE)

func _on_slash_attack_pressed() -> void:
	get_tree().call_group("characters", "actions_switcher", BattleParameters.Action.SLASH_ATTACK)
	#character.actions_switcher(BattleParameters.Action.SLASH_ATTACK)

func _on_pierce_attack_pressed() -> void:
	get_tree().call_group("characters", "actions_switcher", BattleParameters.Action.PIERCE_ATTACK)
	#character.actions_switcher(BattleParameters.Action.PIERCE_ATTACK)

func _on_blunt_attack_pressed() -> void:
	get_tree().call_group("characters", "actions_switcher", BattleParameters.Action.BLUNT_ATTACK)
	#character.actions_switcher(BattleParameters.Action.BLUNT_ATTACK)


func _on_flip_h_toggled(_button_pressed) -> void:
	get_tree().call_group("characters", "flip_view_direction")
	#character.switch_view_direction()


func _on_deal_damage_pressed() -> void:
	get_tree().call_group("characters", "take_damage", 10)
	#character.take_damage(10)


func _on_roll_speed_dice_pressed() -> void:
	get_tree().call_group("characters", "roll_speed_dice")
	#character.roll_speed_dice()


func _on_die_pressed() -> void:
	get_tree().call_group("characters", "die")
	#character.die()

func _on_stun_pressed() -> void:
	get_tree().call_group("characters", "stun")
	#character.stun()



