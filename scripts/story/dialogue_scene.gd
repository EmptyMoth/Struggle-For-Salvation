class_name DialogueScene
extends Control


@export var dialogue: Dialogue
@export_file("*.txt") var path_to_script: String


@onready var speakers: Array = get_children()


func _ready() -> void:
	var text = FileAccess.open(path_to_script, FileAccess.READ).get_as_text().split("\n", false)
	var index = 0
	for line in text:
		var split_line = line.split(" \\ ")
		var speakers_in_text: Array = dialogue.get_speakes(index)
		var dialogue_line: DialogueLine = DialogueLine.new(
				split_line[0], split_line[1], split_line[2], speakers_in_text)
		dialogue.add_line(dialogue_line)
		index += 1


func get_len() -> int:
	return dialogue.get_len()


func set_speakers(index: int) -> void:
	var line: DialogueLine = get_line(index)
	var line_speakers = line.speakers
	
	for speaker in speakers:
		speaker.hide()
	
	for speaker in line_speakers:
		var speaker_node: TextureRect = get_node(speaker)
		#speaker_node.texture = speaker.image
		speaker_node.modulate = Color8(50, 50, 50)
		speaker_node.show()
	
	var current_speaker: TextureRect = get_node_or_null(line.get_current_speaker())
	if current_speaker != null:
		current_speaker.modulate = Color8(255, 255, 255)


func get_line(index: int) -> DialogueLine:
	return dialogue.get_line(index)


func get_lines() -> Array:
	return dialogue.lines
