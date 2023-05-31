class_name ChapterZoomButton
extends TextureButton


signal zoom(source)


@onready var camera: PlayerCamera2D = get_viewport().get_camera_2d()
@export var target: Node
@export var target_zoom: Vector2 = Vector2.ONE


func _on_pressed() -> void:
	zoom_to_target()

func zoom_to_target() -> void:
	camera.zoom_to(target.get_global_position() + (target.size + Settings.get_resolution_difference()) / 2, target_zoom)
	if target is Chapter:
		target.focus()
	zoom.emit(self)
