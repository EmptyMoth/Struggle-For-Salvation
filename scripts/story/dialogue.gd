extends Resource
class_name Dialogue


@export var speakers_by_lines: Dictionary = { 1: [] }

var lines: Array[DialogueLine] = []


func add_line(line: DialogueLine) -> void:
	lines.append(line)


func get_speakes(index: int) -> Array:
	var speakers = speakers_by_lines.get(index + 1)
	if speakers == null:
		speakers = get_line(index - 1).speakers
	return speakers


func get_line(index: int) -> DialogueLine:
	return lines[index]


func get_len() -> int:
	return len(lines)
