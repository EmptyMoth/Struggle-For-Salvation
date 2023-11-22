class_name EvadeDice
extends DefensiveDice


func _to_string() -> String:
	return super() % "E"


func _win_clash(_target: Character) -> void:
	super(_target)
	is_recycled = true
	model.wearer.mental_heal(model.values_model.get_current_value())
	defended.emit()

func _draw_clash(_target: Character) -> void:
	super(_target)
	is_recycled = true
	defended.emit()

func _lose_clash(_target: Character) -> void:
	super(_target)
	is_recycled = false
