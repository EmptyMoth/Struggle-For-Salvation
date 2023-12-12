class_name SubcharacterBars
extends MarginContainer


@onready var _hp_bar: BaseHealthBar = $Panel/HBox/HPBar
@onready var _sp_bar: BaseHealthBar = $Panel/HBox/SPBar


func _ready() -> void:
	_hp_bar.resized.connect(_on_hp_bar_resized)


func set_healths(physical_health: BaseHealth, mental_health: BaseHealth) -> void:
	_hp_bar.set_initial_values(physical_health)
	_sp_bar.set_initial_values(mental_health)
	_on_hp_bar_resized()


func _on_hp_bar_resized() -> void:
	position.x = -_hp_bar.size.x - 2.5
