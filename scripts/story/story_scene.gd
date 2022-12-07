extends Control


enum Autoplay {
	NONE = 0,
	WRITE = 1,
	AUTO = 2,
	FAST = 3
}

const text_inc: int = 1
const auto_delay: int = 100

const scene_log_entry = preload("res://scenes/story/dialogue/log_entry.tscn")

var ui_main: VBoxContainer
var ui_log: MarginContainer
var ui_log_entries: VBoxContainer

var speaker_role: RichTextLabel
var speaker_name: RichTextLabel
var speech: RichTextLabel

var log_entries: Array

#var button_log: Button
#var button_skip: Button
#var button_fast_forward: Button
#var button_autoplay: Button
var button_back: Button
#var button_repeat: Button
var button_next: Button
#var button_hide: Button

var dialogue: Dialogue
var current_line: DialogueLine
var line_count: int
var line_index: int = 0
var speaker_dict: Dictionary

var text_write: int = 0
#var lines: Array
#var characters: Dictionary

var auto_counter: int = 0
var log_line: int = 0
var ui_hidden: bool = false


func _ready() -> void:
	ui_main = $VBoxContainer
	ui_log = $Log
	ui_log_entries = ui_log.get_node("PanelContainer/VBoxContainer/ScrollContainer/MarginContainer/VBoxContainer")
	speaker_role = ui_main.get_node("SpeakerRole")
	speaker_name = ui_main.get_node("SpeakerName")
	speech = ui_main.get_node("ColourRect/MarginContainer/Text")
	
	var path = ui_main.get_node("CenterContainer/HBoxContainer")
	button_next = path.get_node("ButtonNext")
	button_back = path.get_node("ButtonBack")
	
	load_dialogue("res://resources/story/test_dialogue/test_dialogue.tres")
	inc_line(0)
	display_line()
	#pass


func _process(delta: float) -> void:
	match(text_write):
		Autoplay.NONE:
			pass
		Autoplay.WRITE:
			if(auto_counter > text_inc):
				speech.visible_characters += 1#delta * text_inc
				auto_counter = 0
			else:
				auto_counter += 1
			if(len(speech.text) <=speech.visible_characters):
				text_write = Autoplay.NONE
				speech.visible_characters = -1
		Autoplay.AUTO:
			if(len(speech.text) <=speech.visible_characters):
				auto_counter += 1
				if(auto_counter > auto_delay):
					inc_line()
					auto_counter = 0
			elif(auto_counter > text_inc):
				speech.visible_characters += 1
				auto_counter = 0
			else:
				auto_counter += 1
		Autoplay.FAST:
			if(len(speech.text) <=speech.visible_characters):
				inc_line()
			else:
				speech.visible_characters += 2


func end_dialogue() -> void:
	text_write = Autoplay.NONE


func load_dialogue(path: String) -> void:
	dialogue = load(path)
	line_count = dialogue.get_len()
	
	for line in dialogue.lines:
		var entry = scene_log_entry.instantiate()
		entry.init(line.speaker_role, line.speaker_name, line.line)
		log_entries.append(entry)
		ui_log_entries.add_child(entry)
	
	var speakers = [$Speakers/Speaker0, $Speakers/Speaker1, $Speakers/Speaker2, $Speakers/Speaker3, $Speakers/Speaker4, $Speakers/Speaker5]
	var t = 0
	for key in dialogue.speakers.keys():
		speaker_dict[key] = speakers[t]
		t += 1
		speaker_dict[key].texture = dialogue.speakers[key].image
		speaker_dict[key].get_node("Expression").texture = dialogue.speakers[key].expressions[Speaker.Expressions.EXPRESSION_DEFAULT]
		speaker_dict[key].get_node("Shadow").texture = dialogue.speakers[key].shadow


func inc_line(inc: int = 1) -> void:
	if(inc > 0 and line_index >= line_count - 1):
		end_dialogue()
		return
	line_index += inc
	if(log_line <= line_index):
		log_line = line_index + 1
		update_log()
	display_line()
	
	if(line_index >= line_count - 1):
		button_next.disabled = true
		if(text_write == Autoplay.AUTO):
			text_write = Autoplay.WRITE
	else:
		button_next.disabled = false
	if(line_index <= 0):
		button_back.disabled = true
	else:
		button_back.disabled = false


func display_line() -> void:
	var auto = text_write
	if(auto == Autoplay.NONE):
		auto = Autoplay.WRITE
	text_write = Autoplay.NONE
	current_line = dialogue.get_line(line_index)
	speaker_role.text = current_line.speaker_role#characters[lines[line_index][0]][0]
	speaker_name.text = current_line.speaker_name
	speech.visible_characters = 0
	speech.text = current_line.line#lines[line_index][2]
	text_write = auto
	
	for key in speaker_dict.keys():
		var speaker = dialogue.speakers[key]
		if(current_line.speakers.has(speaker)):
			speaker_dict[key].get_node("Shadow").hide()
			speaker_dict[key].get_node("Expression").texture = speaker.expressions[current_line.expression]
		else:
			speaker_dict[key].get_node("Shadow").show()


func update_log() -> void:
	for t in log_line:
		log_entries[t].show()


func _on_button_log_pressed() -> void:
	ui_main.hide()
	ui_log.show()


func _on_button_back_pressed() -> void:
	text_write = Autoplay.NONE
	inc_line(-1)
	speech.visible_characters = -1


func _on_button_next_pressed() -> void:
	if(ui_hidden):
		ui_main.show()
		ui_hidden = false
		return
	
	if(line_index >= line_count - 1):
		return
		
	match(text_write):
		Autoplay.NONE:
			inc_line()
		Autoplay.WRITE:
			text_write = Autoplay.NONE
			speech.visible_characters = -1
		Autoplay.AUTO:
			text_write = Autoplay.NONE
			speech.visible_characters = -1
		Autoplay.FAST:
			text_write = Autoplay.NONE
			speech.visible_characters = -1


func _on_button_skip_pressed() -> void:
	pass


func _on_button_fast_forward_pressed() -> void:
	text_write = Autoplay.FAST


func _on_button_autoplay_pressed() -> void:
	text_write = Autoplay.AUTO


func _on_button_hide_pressed() -> void:
	ui_main.hide()
	ui_hidden = true


func _on_button_repeat_pressed():
	text_write = Autoplay.NONE
	display_line()


func _on_color_rect_gui_input(event: InputEvent) -> void:
	if(event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed):
		_on_button_next_pressed()


func _on_button_close_log_pressed():
	ui_log.hide()
	ui_main.show()
