class_name AbstractHealth
extends Resource


signal health_changed(new_value: int)

var max_health: int = 0
var current_health: int = 0 : 
	set(health):
		current_health = health
		if health == 0:
			_reached_zero()
		
		@warning_ignore("return_value_discarded")
		emit_signal("health_changed", current_health)


func _init(max_value: int) -> void:
	max_health = max_value
	reset()


func is_empty() -> bool:
	return current_health <= 0


func reset() -> void:
	current_health = max_health


func reduce_max_value(value: int) -> void:
	max_health = max(1, max_health - value)


func take_damage(value: int, resistance_value: float) -> void:
	var damage: int = roundi(value * resistance_value)
	current_health = max(0, current_health - damage)
	if is_empty():
		_reached_zero()


func heal(value: int) -> void:
	current_health = min(current_health + value, max_health)


func _reached_zero() -> void:
	pass
