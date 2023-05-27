extends Control


enum Autoplay {
	NONE = 0,
	WRITE = 1,
	AUTO = 2,
	FAST = 3
}

const text_inc: int = 1
const auto_delay: int = 100

const scene_log_entry = preload("res://scenes/story/log/log_entry.tscn")

@onready var pause_menu = $PauseMenu

var ui_main: VBoxContainer
var ui_log: Log
var ui_log_entries: VBoxContainer

var speaker_role: RichTextLabel
var speaker_name: RichTextLabel
var speech: RichTextLabel

var log_entries: Array

var button_back: Button
var button_next: Button

var dialogue: DialogueScene
var current_line: DialogueLine
var line_count: int
var line_index: int = 0
var speaker_dict: Dictionary

var text_write: int = 0

var auto_counter: int = 0
var log_line: int = 0
var ui_hidden: bool = false


func _ready() -> void:
	ui_main = $VBoxContainer
	ui_log = $Log
	ui_log_entries = ui_log.log_entries
	speaker_role = ui_main.get_node("SpeakerRole")
	speaker_name = ui_main.get_node("SpeakerName")
	speech = ui_main.get_node("ColourRect/MarginContainer/Text")
	
	var path = ui_main.get_node("CenterContainer/HBoxContainer")
	button_next = path.get_node("ButtonNext")
	button_back = path.get_node("ButtonBack")
	
	load_dialogue_scene("res://scenes/story/dialogue/test_dialogue/dialogue_scene_test.tscn")
	inc_line(0)
	display_line()


func _process(delta: float) -> void:
	match text_write:
		Autoplay.NONE:
			pass
		Autoplay.WRITE:
			autoplay_write()
		Autoplay.AUTO:
			autoplay_auto()
		Autoplay.FAST:
			autoplay_fast()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("ui_menu") and !pause_menu.just_closed:
		pause_menu.pause_game()
	pause_menu.just_closed = false


func autoplay_write() -> void:
	if auto_counter > text_inc:
		speech.visible_characters += 1
		auto_counter = 0
	else:
		auto_counter += 1
	
	if len(speech.text) <=speech.visible_characters:
		text_write = Autoplay.NONE
		speech.visible_characters = -1


func autoplay_auto() -> void:
	if len(speech.text) <=speech.visible_characters:
		auto_counter += 1
		if auto_counter > auto_delay:
			inc_line()
			auto_counter = 0
	elif auto_counter > text_inc:
		speech.visible_characters += 1
		auto_counter = 0
	else:
		auto_counter += 1


func autoplay_fast() -> void:
	if len(speech.text) <=speech.visible_characters:
		inc_line()
	else:
		speech.visible_characters += 2


func end_dialogue() -> void:
	text_write = Autoplay.NONE


func load_dialogue_scene(path: String) -> void:
	dialogue = load(path).instantiate()
	add_child(dialogue)
	move_child(dialogue, 1)
	dialogue.gui_input.connect(_on_color_rect_gui_input)
	line_count = dialogue.get_len()
	_populate_log(dialogue.path_to_script)


func _populate_log(path: String) -> void:
	var text = FileAccess.open(path, FileAccess.READ).get_as_text().split("\n", false)
	for line in text:
		var entry = scene_log_entry.instantiate()
		var split_line = line.split(" \\ ")
		entry.init(split_line[0], split_line[1], split_line[2])
		log_entries.append(entry)
		ui_log_entries.add_child(entry)


func inc_line(inc: int = 1) -> void:
	if inc > 0 and line_index >= line_count - 1:
		end_dialogue()
		return
	
	line_index += inc
	
	if log_line <= line_index:
		log_line = line_index + 1
		update_log()
	display_line()
	
	if line_index >= line_count - 1:
		button_next.set_disabled(true)
		if text_write == Autoplay.AUTO:
			text_write = Autoplay.WRITE
	else:
		button_next.set_disabled(false)
	
	button_back.set_disabled(line_index <= 0)


func display_line() -> void:
	var auto = text_write
	if auto == Autoplay.NONE:
		auto = Autoplay.WRITE
	text_write = Autoplay.NONE
	current_line = dialogue.get_line(line_index)
	speaker_role.text = current_line.speaker_role
	speaker_name.text = current_line.speaker_name
	speech.visible_characters = 0
	speech.text = current_line.line
	text_write = auto
	
	dialogue.set_speakers(line_index)


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
	if ui_hidden:
		ui_main.show()
		ui_hidden = false
		return
	
	if line_index >= line_count - 1:
		speech.visible_characters = -1
		text_write = Autoplay.NONE
		return
		
	match text_write:
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
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_on_button_next_pressed()


func _on_button_close_log_pressed():
	ui_log.hide()
	ui_main.show()
