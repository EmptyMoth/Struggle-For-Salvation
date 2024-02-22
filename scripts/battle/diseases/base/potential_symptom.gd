class_name PotentialSymptom
extends Resource


@export_range(0.0, 1.0, 0.05) var development_chance: float = 1.0
@export var symptom: AbstractSymptom

@export_category("Additionally")
@export var alternative_symptom: AbstractSymptom = null

var has_developed: bool = false
var current_symptom: AbstractSymptom = null


func try_develop() -> bool:
	has_developed = randf() <= development_chance
	if has_developed:
		current_symptom = symptom if alternative_symptom == null or randf() <= 0.5 else alternative_symptom
	return has_developed
