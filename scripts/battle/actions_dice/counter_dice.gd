class_name CounterDice
extends OffensiveDice


func _init(dice: AbstractActionDice, skill: SkillCombatModel) -> void:
	is_avoids_clash = true
	super(dice, skill)


func _to_string() -> String:
	return super() % "C"
