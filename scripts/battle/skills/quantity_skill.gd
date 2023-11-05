class_name QuantitySkill
extends AbstractSkill


var current_quantity: int = 0


func _init(character: Character, skill_stats: SkillStats = SkillStats.new()) -> void:
	super(character, skill_stats)
	current_quantity = stats.quantity


func is_available() -> bool:
	return current_quantity > 0


func select() -> void:
	current_quantity -= 1

func deselect() -> void:
	current_quantity += 1


func _on_battle_turn_started() -> void:
	current_quantity = stats.quantity
