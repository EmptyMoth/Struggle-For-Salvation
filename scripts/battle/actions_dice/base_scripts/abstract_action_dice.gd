class_name AbstractActionDice
extends Node


enum DiceType {
	ATTACK_DICE = 0,
	BLOCK_DICE = 1,
	EVADE_DICE = 2,
	COUNTER_ATTACK_DICE = 3,
	COUNTER_BLOCK_DICE = 4,
	COUNTER_EVADE_DICE = 5,
}

@export var min_value: int = 0
@export var max_value: int = 1

var current_value: int = 0
var dice_type: DiceType = DiceType.ATTACK_DICE
var ability: AbstractAbility = NoAbility.new()

var _action: Action


func roll_dice() -> void:
	current_value = GlobalParameters.random.randi_range(min_value, max_value)


func analyze_clash(
		result: BattleParameters.ClashResults, 
		dice_type: AbstractActionDice.DiceType,
		dice_value: int) -> void:
	if result == BattleParameters.ClashResults.WIN:
		_winning_a_clash(dice_type, dice_value)
	elif result == BattleParameters.ClashResults.DRAW:
		_drawing_a_clash(dice_type, dice_value)
	else:
		_losing_a_clash(dice_type, dice_value)


func _winning_a_clash(dice_type: AbstractActionDice.DiceType, dice_value: int) -> void:
	pass


func _drawing_a_clash(dice_type: AbstractActionDice.DiceType, dice_value: int) -> void:
	pass


func _losing_a_clash(dice_type: AbstractActionDice.DiceType, dice_value: int) -> void:
	pass


func _break_dice() -> void:
	pass
