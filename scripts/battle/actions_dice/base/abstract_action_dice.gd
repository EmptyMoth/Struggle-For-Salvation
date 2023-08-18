class_name AbstractActionDice
extends Resource


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
@export var mation: BattleParameters.CharactersActions = \
		BattleParameters.CharactersActions.DEFAULT
@export var ability: AbstractAbility = NoAbility.new()

var current_value: int = 0
var dice_type: DiceType = DiceType.ATTACK_DICE


func roll_dice() -> void:
	current_value = GlobalParameters.random.randi_range(min_value, max_value)


func _break_dice() -> void:
	pass


func use_on_one_side() -> void:
	pass


func use_on_clash(result: BattleParameters.ClashResults) -> void:
	match result:
		BattleParameters.ClashResults.WIN:
			_winning_a_clash()
		BattleParameters.ClashResults.DRAW:
			_drawing_a_clash()
		BattleParameters.ClashResults.LOSE:
			_losing_a_clash()


func _winning_a_clash() -> void:
	pass


func _drawing_a_clash() -> void:
	pass


func _losing_a_clash() -> void:
	pass
