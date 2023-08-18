class_name AbstractSkill
extends Resource


@export_range(-10, 10, 1, "or_less", "or_greater") var priority: int = 0


func is_blocked() -> bool:
	return false


func select() -> void:
	pass

func deselect() -> void:
	pass


func use() -> void:
	pass


func _on_battle_turn_started(_turn_number: int) -> void:
	pass
