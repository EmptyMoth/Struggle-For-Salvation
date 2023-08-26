class_name AbstractActionDice
extends Resource


signal break_down

@export var stats: ActionDiceStats

static var losing_action := DiceAction.new(
		BattleParameters.CharactersMotions.STUN, AbstractActionDice._none_action)

var is_breaked: bool = false
var is_recycled: bool = false
var bonus: ActionDiceBonus = ActionDiceBonus.new()

var _current_value: int = 0


func _init(_stats: ActionDiceStats = ActionDiceStats.new()) -> void:
	stats = _stats


static func create_dice(_stats: ActionDiceStats) -> AbstractActionDice:
	match _stats.dice_type:
		ActionDiceStats.DiceType.ATTACK:
			return AttackDice.new(_stats)
		ActionDiceStats.DiceType.BLOCK:
			return BlockDice.new(_stats)
		ActionDiceStats.DiceType.EVADE:
			return EvadeDice.new(_stats)
		_:
			return CounterDice.new(_stats)


func get_color() -> Color:
	return Color.WHITE_SMOKE


func get_default_min_value() -> int:
	return stats.min_value

func get_default_max_value() -> int:
	return stats.max_value

func get_default_current_value() -> int:
	return _current_value


func get_min_value() -> int:
	return stats.min_value + bonus.min_value

func get_max_value() -> int:
	return stats.max_value + bonus.max_value

func get_current_value() -> int:
	if bonus.ignore_power:
		return _current_value
	return _current_value + bonus.power


func roll_dice() -> void:
	_current_value = randi_range(get_min_value(), get_max_value())


func break_dice() -> void:
	break_down.emit()


func use_on_one_side() -> DiceAction:
	return stats.action.init(_none_action)


func use_on_clash(opponent_dice: AbstractActionDice, 
			result: BattleParameters.ClashResults) -> DiceAction:
	is_breaked = true
	match result:
		BattleParameters.ClashResults.WIN:
			return _win_on_clash(opponent_dice)
		BattleParameters.ClashResults.LOSE:
			return _lose_on_clash(opponent_dice)
		_:
			return _draw_on_clash(opponent_dice)


func _win_on_clash(_opponent_dice: AbstractActionDice) -> DiceAction:
	return stats.action.init(_action)

func _draw_on_clash(_opponent_dice: AbstractActionDice) -> DiceAction:
	return stats.action.init(_none_action)

func _lose_on_clash(_opponent_dice: AbstractActionDice) -> DiceAction:
	return AbstractActionDice.losing_action


func _action(character: AbstractCharacter, target: AbstractCharacter) -> void:
	pass

static func _none_action(character: AbstractCharacter, target: AbstractCharacter) -> void:
	pass
