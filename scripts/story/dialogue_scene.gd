class_name DialogueScene
extends Control


@export var path_to_script: String
@export var dialogue: Dialogue

var speakers: Array
var speakers_active: Array


func _ready() -> void:
	speakers = get_children()
	for t in len(speakers):
		speakers_active.append(false)
	
	var text = FileAccess.open(path_to_script, FileAccess.READ).get_as_text().split("\n", false)
	var index = 0
	for line in text:
		var split_line = line.split(" \\ ")
		var d_line = dialogue.get_line(index)
		index += 1
		
		d_line.speaker_name = split_line[0]
		d_line.speaker_role = split_line[1]
		d_line.line = split_line[2]


func get_len() -> int:
	return dialogue.get_len()


func set_speakers(index: int) -> void:
	var line_speakers = get_line(index).speakers
	
	for speaker in line_speakers:
		var t = speaker.index
		if t == -1:
			continue
		speakers[t].texture = line_speakers[t].image
		speakers[t].get_node("Expression").texture = line_speakers[t].expression
		speakers_active[t] = true
	
	for t in len(speakers_active):
		if !speakers_active[t]:
			speakers[t].modulate = Color8(10, 10, 10, 255)
		else:
			speakers[t].modulate = Color8(255, 255, 255, 255)
	
	reset_activity()


func get_line(index: int) -> DialogueLine:
	return dialogue.get_line(index)


func get_lines() -> Array:
	return dialogue.lines


func reset_activity() -> void:
	for t in len(speakers):
		speakers_active[t] = false
