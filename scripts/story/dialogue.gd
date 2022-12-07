extends Resource
class_name Dialogue


@export var speakers: Dictionary
@export var lines: Array


func _ready() -> void:
	pass


func get_speakers(index: int) -> Array:
	return lines[index].speakers


func get_line(index: int) -> DialogueLine:
	return lines[index]


func get_len() -> int:
	return len(lines)
