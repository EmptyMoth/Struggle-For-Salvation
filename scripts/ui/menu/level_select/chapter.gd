class_name Chapter
extends Control


@export var zoom_button: ChapterZoomButton

@onready var default_texture = $TextureInactive
@onready var focused_texture = $TextureFocused


func _ready() -> void:
	size = default_texture.size


func focus() -> void:
	default_texture.hide()
	focused_texture.show()


func unfocus() -> void:
	focused_texture.hide()
	default_texture.show()
	


func _on_texture_inactive_gui_input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		zoom_button.zoom_to_target()
