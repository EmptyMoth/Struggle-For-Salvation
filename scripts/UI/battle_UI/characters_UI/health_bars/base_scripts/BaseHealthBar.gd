class_name BaseHealthBar
extends TextureProgressBar


var _animation_time: float = 0.6

@onready var _counter_label: Label = $Counter


func _process(_delta: float) -> void:
	_counter_label.text = str(value)


func set_initial_values(max_health: int, current_hralth: int) -> void:
	max_value = max_health
	_update_bars(current_hralth)


func _update_bars(new_value: int) -> void:
	var tween: Tween = create_tween()\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "value", new_value, _animation_time)


func _on_health_changed(new_health: int) -> void:
	_update_bars(new_health)
