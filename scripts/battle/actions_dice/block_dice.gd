class_name BlockDice
extends AbstractActionDice


func _init(_stats: ActionDiceStats, skill: SkillCombatModel) -> void:
	is_goes_to_reserve = true
	super(_stats, skill)


func _to_string() -> String:
	return super() % "B"


static func get_color() -> Color:
	return Color("5C8AE5")


func use(target: CharacterCombatModel, mental_damage: int = -1) -> void:
	is_used = true
	target.take_mental_damage(current_value if mental_damage == -1 else mental_damage)


func _win_clash(target: CharacterCombatModel) -> void:
	var opponent_dice: AbstractActionDice = target.current_action_dice
	var damage: int = current_value
	if opponent_dice is AttackDice:
		damage -= opponent_dice.current_value
	use(target, damage)

func _draw_clash(target: CharacterCombatModel) -> void:
	pass

func _lose_clash(target: CharacterCombatModel) -> void:
	pass
