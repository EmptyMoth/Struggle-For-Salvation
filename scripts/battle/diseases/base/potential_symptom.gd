class_name PotentialSymptom
extends Resource


@export_range(0.0, 1.0, 0.05) var development_chance: float = 1.0
@export var symptom_activation_condition: AbstractSymptomAbilityCondition
@export var symptom: AbstractSymptom

@export_category("Additionally")
@export var alternative_symptom: AbstractSymptom = null

var has_developed: bool = false
var current_symptom: AbstractSymptom = null


func _to_string() -> String:
	return "%s\n%s %s"


func try_develop() -> bool:
	has_developed = randf() <= development_chance
	if has_developed:
		current_symptom = symptom if alternative_symptom == null or randf() <= 0.5 else alternative_symptom
		if symptom_activation_condition == null:
			current_symptom.effect()
		symptom_activation_condition.connect_condition(current_symptom.effect)
	return has_developed
