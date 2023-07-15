class_name MonitoringSubViewportContainer
extends SubViewportContainer


@onready var viewport: SubViewport = get_children().front()


func _ready():
	Settings.graphics_settings.changed_graphics_quality.connect(_on_changed_graphics_quality)


func _on_changed_graphics_quality(new_graphic_quality) -> void:
	viewport.scaling_3d_scale = 0.35 * (new_graphic_quality + 1)
