class_name MonitoringSubViewportContainer
extends SubViewportContainer


@onready var viewport: SubViewport = get_children().front()


func _ready():
	Settings.graphics_settings.graphics_quality.setting_changed.connect(_on_graphics_quality_changed)


func _on_graphics_quality_changed(new_graphic_quality: int) -> void:
	viewport.scaling_3d_scale = 0.35 * (new_graphic_quality + 1)
