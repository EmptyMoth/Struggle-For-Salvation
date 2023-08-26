class_name QuantitySkill
extends AbstractSkill


var current_quantity: int = 0


func _init(skill_stats: SkillStats = SkillStats.new()) -> void:
	super()
	stats = skill_stats
	current_quantity = stats.quantity


func is_blocked() -> bool:
	return current_quantity == 0


func select() -> void:
	current_quantity -= 1

func deselect() -> void:
	current_quantity += 1


func _on_battle_turn_started(_turn_number: int) -> void:
	current_quantity = stats.quantity
