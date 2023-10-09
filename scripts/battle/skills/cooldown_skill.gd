class_name CooldownSkill
extends AbstractSkill


var is_selected: bool = false
var current_cooldown: int = 0


func is_available() -> bool:
	return not is_selected or current_cooldown <= 0


func select() -> void:
	is_selected = true

func deselect() -> void:
	is_selected = false


func reduce_cooldown(count: int) -> void:
	current_cooldown = max(0, current_cooldown - count)

func increase_cooldown(count: int) -> void:
	current_cooldown = current_cooldown + count


func _on_battle_turn_started() -> void:
	is_selected = false
	if not is_available():
		reduce_cooldown(1)
