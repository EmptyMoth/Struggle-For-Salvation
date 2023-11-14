class_name AttackDice
extends OffensiveDice


func _init(_stats: ActionDiceStats, skill: SkillCombatModel) -> void:
	super(_stats, skill)


func _to_string() -> String:
	return super() % "A"


static func get_color() -> Color:
	return Color("E54646")


func use(target: CharacterCombatModel, damage: int = -1) -> void:
	is_used = true
	target.take_damage(current_value if damage == -1 else damage)


func _win_clash(target: CharacterCombatModel) -> void:
	var opponent_dice: AbstractActionDice = target.current_action_dice
	var damage: int = current_value
	if opponent_dice is BlockDice:
		damage -= opponent_dice.current_value
	use(target, damage)

func _draw_clash(target: CharacterCombatModel) -> void:
	pass

func _lose_clash(target: CharacterCombatModel) -> void:
	pass
