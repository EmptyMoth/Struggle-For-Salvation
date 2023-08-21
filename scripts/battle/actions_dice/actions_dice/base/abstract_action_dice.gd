class_name AbstractActionDice
extends Resource


@export_range(0, 99, 1, "or_greater") var min_value: int = 0
@export_range(0, 99, 1, "or_greater") var max_value: int = 1
@export var motion: BattleParameters.CharactersMotions = \
		BattleParameters.CharactersMotions.DEFAULT
@export var abilities: Array[BaseActionDiceAbility] = []
@export var action_animation: ActionAnimation

var current_value: int = 0
var is_retossed: bool = false


func get_color() -> Color:
	return Color.TRANSPARENT


func has_ability() -> bool:
	return abilities.size() > 0


func roll_dice() -> void:
	current_value = randi_range(min_value, max_value)


func break_dice() -> void:
	pass


func use_on_one_side() -> AbstractDiceAction:
	return AbstractDiceAction.new()


func use_on_clash(
			action_dice: AbstractDiceAction, 
			result: BattleParameters.ClashResults) -> AbstractDiceAction:
	match result:
		BattleParameters.ClashResults.WIN:
			return _win_on_clash(action_dice)
		BattleParameters.ClashResults.DRAW:
			return _draw_on_clash(action_dice)
		_:
			return _lose_on_clash(action_dice)


func _win_on_clash(_action_dice: AbstractDiceAction) -> AbstractDiceAction:
	return AbstractDiceAction.new()


func _draw_on_clash(_action_dice: AbstractDiceAction) -> AbstractDiceAction:
	return AbstractDiceAction.new()


func _lose_on_clash(_action_dice: AbstractDiceAction) -> AbstractDiceAction:
	return AbstractDiceAction.new()
