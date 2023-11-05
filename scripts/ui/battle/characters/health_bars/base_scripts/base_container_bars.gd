class_name BaseContainerBars
extends Control


@onready var _physical_health_bar: BaseHealthBar = $PHPBar
@onready var _mental_health_bar: BaseHealthBar = $MHPBar


func init(physical_health: PhysicalHealth, mental_health: MentalHealth) -> void:
	_init_bar(_physical_health_bar, physical_health)
	_init_bar(_mental_health_bar, mental_health)


func set_values_on_bars(physical_health: PhysicalHealth, mental_health: MentalHealth) -> void:
	_set_value_on_bar(_physical_health_bar, physical_health)
	_set_value_on_bar(_mental_health_bar, mental_health)


func _set_value_on_bar(health_bar: BaseHealthBar, health: AbstractHealth) -> void:
	health_bar.set_values(health)


func _init_bar(health_bar: BaseHealthBar, health: AbstractHealth) -> void:
	health_bar.set_initial_values(health)
	# !!!!!!!!
	@warning_ignore("return_value_discarded")
	health.health_changed.connect(health_bar._on_health_changed)
