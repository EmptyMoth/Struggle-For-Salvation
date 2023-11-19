@tool
class_name BaseHealthBar
extends HBoxContainer


@export var _is_left: bool = true :
	set(is_left):
		_is_left = is_left
		move_child($Bar, 1 if is_left else 0)

@onready var _bar: ProgressBar = $Bar
@onready var _counter_label: Label = $Counter


func set_initial_values(health: AbstractHealth) -> void:
	health.health_changed.connect(_update_bar)
	_bar.max_value = health.max_health
	_update_bar(health.current_health)


func _update_bar(new_value: int) -> void:
	create_tween() \
		.set_ease(Tween.EASE_OUT) \
		.set_trans(Tween.TRANS_CUBIC) \
		.tween_property(_bar, "value", new_value, 0.6)


func _on_bar_value_changed(new_value: float) -> void:
	_counter_label.text = str(roundf(new_value))
