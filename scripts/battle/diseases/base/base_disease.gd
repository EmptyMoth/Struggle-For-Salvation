class_name BaseDisease
extends Resource


signal progressed(new_symptoms: Array[AbstractSymptom])

@export var _stages: Array[DiseaseStage] = []

var _battle: BaseBattle
var _next_stage_index: int


func init(battle: BaseBattle) -> void:
	_next_stage_index = 0
	_battle = battle
	BattleSignals.turn_started.connect(progress)


func progress() -> void:
	if _next_stage_index >= _stages.size():
		BattleSignals.turn_started.disconnect(progress)
		return
	var stage: DiseaseStage = _stages[_next_stage_index]
	if _battle.turn_number >= stage.turn_count_before_development:
		stage.develop(_battle)
		_next_stage_index += 1
