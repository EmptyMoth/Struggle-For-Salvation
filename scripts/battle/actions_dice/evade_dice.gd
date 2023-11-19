class_name EvadeDice
extends DefensiveDice


func _to_string() -> String:
	return super() % "E"


func _win_clash(_target: CharacterCombatModel) -> void:
	is_recycled = true
	wearer.mental_heal(model.values_model.get_current_value())

func _draw_clash(_target: CharacterCombatModel) -> void:
	is_recycled = true

func _lose_clash(_target: CharacterCombatModel) -> void:
	is_recycled = false
