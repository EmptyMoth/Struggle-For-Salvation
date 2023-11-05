class_name AbstractHUD
extends Control


var bars: BaseContainerBars


func init(physical_health: PhysicalHealth, mental_health: MentalHealth) -> void:
	bars.init(physical_health, mental_health)
