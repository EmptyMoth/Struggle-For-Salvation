class_name SubcharacterBars
extends Control


@onready var _physical_health_bar: BaseHealthBar = $Bars/PhysicalHealthBar
@onready var _mental_health_bar: BaseHealthBar = $Bars/MentalHealthBar


func init(physical_health: PhysicalHealth, mental_health: MentalHealth) -> void:
	_init_bar(_physical_health_bar, physical_health)
	_init_bar(_mental_health_bar, mental_health)

func _init_bar(health_bar: BaseHealthBar, health: AbstractHealth) -> void:
	health_bar.set_initial_values(health.max_health, health.current_health)
	health.health_changed.connect(health_bar._on_health_changed)
