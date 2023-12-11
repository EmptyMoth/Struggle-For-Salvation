class_name CooldownSkillType
extends AbstractSkillUseType


var cooldown: int = 0
var is_cooldown: bool = false

var _data: CooldownData


func _init(data: AbstractSkillUseTypeData) -> void:
	if not data is CooldownData:
		push_error("attempt to install data not related to cooldown skill type")
	_data = data


func is_available() -> bool:
	return cooldown == 0


func select() -> void:
	cooldown = _data.cooldown

func deselect() -> void:
	cooldown = 0


func restore() -> void:
	if is_cooldown:
		reduce_cooldown(1)
	else:
		cooldown = 0


func reduce_cooldown(count: int) -> void:
	cooldown = min(0, cooldown - count)
	is_cooldown = cooldown > 0

func increase_cooldown(count: int) -> void:
	cooldown += count


func _on_skill_used() -> void:
	cooldown = _data.cooldown + 1
	is_cooldown = true
