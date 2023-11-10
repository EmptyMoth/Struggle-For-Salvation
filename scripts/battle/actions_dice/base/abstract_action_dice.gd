class_name AbstractActionDice
extends Resource


signal break_down

@export var stats: ActionDiceStats

static var losing_action := DiceAction.new(
		BattleParameters.CharactersMotions.STUN, AbstractActionDice._none_action)

var wearer: CharacterCombatModel :
	get: return wearer_skill.wearer

var current_value: int = 0
var is_used: bool = false
var is_destroyed: bool = false
var is_recycled: bool = false
var is_responds: bool = false
var wearer_skill: SkillCombatModel
var bonus: ActionDiceBonus = ActionDiceBonus.new()


func _init(_stats: ActionDiceStats, skill: SkillCombatModel) -> void:
	stats = _stats
	wearer_skill = skill


#static func create_dice(_stats: ActionDiceStats, skill: SkillCombatModel) -> AbstractActionDice:
#	match _stats.dice_type:
#		ActionDiceStats.DiceType.ATTACK:
#			return AttackDice.new(_stats, skill)
#		ActionDiceStats.DiceType.BLOCK:
#			return BlockDice.new(_stats, skill)
#		ActionDiceStats.DiceType.EVADE:
#			return EvadeDice.new(_stats, skill)
#		_:
#			return CounterDice.new(_stats, skill)


static func get_color() -> Color:
	return Color.WHITE_SMOKE


func get_default_min_value() -> int:
	return stats.min_value

func get_default_max_value() -> int:
	return stats.max_value

func get_default_current_value() -> int:
	return current_value


func get_min_value() -> int:
	return stats.min_value + bonus.min_value

func get_max_value() -> int:
	return stats.max_value + bonus.max_value

func get_current_value() -> int:
	if bonus.ignore_power:
		return current_value
	return current_value + bonus.power


func roll_dice() -> void:
	current_value = randi_range(get_min_value(), get_max_value())


func compare_to(opponent_dice: AbstractActionDice) -> int:
	return clampi(current_value - opponent_dice.current_value, -1, 1)


func break_dice() -> void:
	break_down.emit()


func is_used_on_one_sided() -> bool:
	return false


func will_go_into_reserve(opponent_dice: AbstractActionDice) -> bool:
	return false


func use(target: CharacterCombatModel) -> DiceAction:
	is_used = true
	return stats.action.init(_none_action)


func use_in_clash(target: CharacterCombatModel, clash_result: BattleEnums.ClashResult) -> void:
	match clash_result:
		BattleEnums.ClashResult.WIN:
			_win_clash(target)
		BattleEnums.ClashResult.LOSE:
			_lose_clash(target)
		_:
			_draw_clash(target)


func _win_clash(target: CharacterCombatModel) -> void:
	pass

func _draw_clash(target: CharacterCombatModel) -> void:
	pass

func _lose_clash(target: CharacterCombatModel) -> void:
	pass


func _action(_character: Character, _target: Character) -> void:
	pass

static func _none_action(_character: Character, _target: Character) -> void:
	pass
