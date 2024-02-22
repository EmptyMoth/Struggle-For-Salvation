class_name DiseaseStage
extends Resource


@export_range(0, 20, 1) var turn_count_before_development: int = 0
@export var symptoms: Array[PotentialSymptom] = []


func develop(battle: BaseBattle) -> void:
	for symptom: PotentialSymptom in symptoms:
		symptom.try_develop()
		if symptom.has_developed:
			symptom.current_symptom.init(null, null, null, battle)
