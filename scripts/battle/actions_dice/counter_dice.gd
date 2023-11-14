class_name CounterDice
extends OffensiveDice


func _init(_stats: ActionDiceStats, skill: SkillCombatModel) -> void:
	is_responds = true
	is_goes_to_reserve = true
	is_avoids_clash = true
	super(_stats, skill)


func _to_string() -> String:
	return super() % "C"


static func get_color() -> Color:
	return Color("EEEE48")


func use(target: CharacterCombatModel) -> void:
	is_used = true
	target.take_damage(current_value)
