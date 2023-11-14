class_name EvadeDice
extends AbstractActionDice


func _init(_stats: ActionDiceStats, skill: SkillCombatModel) -> void:
	is_goes_to_reserve = true
	super(_stats, skill)


func _to_string() -> String:
	return super() % "E"


static func get_color() -> Color:
	return Color("73E573")


func use(target: CharacterCombatModel) -> void:
	is_used = true


func _win_clash(target: CharacterCombatModel) -> void:
	wearer.mental_heal(current_value)
	is_recycled = true

func _draw_clash(target: CharacterCombatModel) -> void:
	is_recycled = true

func _lose_clash(target: CharacterCombatModel) -> void:
	pass
