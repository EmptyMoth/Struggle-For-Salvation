extends Control


var focused_chapter: Chapter


func _ready() -> void:
	var container = $CanvasLayer/HBoxContainer
	for child in container.get_children():
		if child is ChapterZoomButton:
			child.zoom.connect(_on_zoom)


func _on_zoom(sender: ChapterZoomButton) -> void:
	if focused_chapter and focused_chapter != sender.target:
		focused_chapter.unfocus()
	if sender.target is Chapter:
		focused_chapter = sender.target
