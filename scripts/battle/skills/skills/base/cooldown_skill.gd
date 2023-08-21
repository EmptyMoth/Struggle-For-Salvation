class_name CooldownSkill
extends AbstractSkill


@export var stats: CooldownSkillStats

var is_selected: bool = false
var current_cooldown: int = 0


func _init(skill_stats: CooldownSkillStats = CooldownSkillStats.new()) -> void:
	super()
	stats = skill_stats


func is_blocked() -> bool:
	return is_selected or current_cooldown > 0


func select() -> void:
	is_selected = true

func deselect() -> void:
	is_selected = false


func reduce_cooldown(count: int) -> void:
	current_cooldown = max(0, current_cooldown - count)

func increase_cooldown(count: int) -> void:
	current_cooldown = current_cooldown + count


func _on_battle_turn_started(_turn_number: int) -> void:
	is_selected = false
	if is_blocked():
		reduce_cooldown(1)