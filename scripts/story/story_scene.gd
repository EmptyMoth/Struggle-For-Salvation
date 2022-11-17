extends Control


enum Autoplay {
	NONE = 0,
	WRITE = 1,
	AUTO = 2,
}

const text_inc: int = 100

var text_write: int = 0
var lines: Array
var characters: Dictionary

var current_line = 0


func _ready() -> void:
	load_lines("res://scenes/story/dialogue/test.txt")
	inc_line(0)
	display_line()
	#pass

func _process(delta: float) -> void:
	match(text_write):
		Autoplay.NONE:
			pass
		Autoplay.WRITE:
			$VBoxContainer/ColorRect/MarginContainer/Text.visible_characters += 1#delta * text_inc
			if(len($VBoxContainer/ColorRect/MarginContainer/Text.text) <=$VBoxContainer/ColorRect/MarginContainer/Text.visible_characters):
				text_write = Autoplay.NONE
				$VBoxContainer/ColorRect/MarginContainer/Text.visible_characters = -1
		Autoplay.AUTO:
			if(len($VBoxContainer/ColorRect/MarginContainer/Text.text) <=$VBoxContainer/ColorRect/MarginContainer/Text.visible_characters):
				inc_line()
			else:
				$VBoxContainer/ColorRect/MarginContainer/Text.visible_characters += 1#delta * text_inc


func end_dialogue() -> void:
	text_write = Autoplay.NONE

func load_lines(path: String) -> void:
	var file = FileAccess.open(path, FileAccess.READ)
	var line = file.get_line()
	var t = 0
	
	while(line != ""):
		var split = line.split(";")
		characters[split[0]] = [split[1], split[2]]
		line = file.get_line()
	
	while(!file.eof_reached()):
		lines.append(file.get_line().split(";"))
		t += 1

func inc_line(inc: int = 1) -> void:
	if(inc > 0 and current_line >= len(lines)):
		end_dialogue()
	current_line += inc
	display_line()
	
	if(current_line >= len(lines) - 1):
		$VBoxContainer/HBoxContainer/ButtonNext.disabled = true
		if(text_write == Autoplay.AUTO):
			text_write = Autoplay.WRITE
	else:
		$VBoxContainer/HBoxContainer/ButtonNext.disabled = false
	if(current_line <= 0):
		$VBoxContainer/HBoxContainer/ButtonBack.disabled = true
	else:
		$VBoxContainer/HBoxContainer/ButtonBack.disabled = false

func display_line() -> void:
	var auto = text_write
	if(auto == Autoplay.NONE):
		auto = Autoplay.WRITE
	text_write = Autoplay.NONE
	$VBoxContainer/SpeakerName.text = characters[lines[current_line][0]][0] + ", " + lines[current_line][0]
	$VBoxContainer/ColorRect/MarginContainer/Text.visible_characters = 0
	$VBoxContainer/ColorRect/MarginContainer/Text.text = lines[current_line][2]
	text_write = auto


func _on_button_log_pressed() -> void:
	pass

func _on_button_back_pressed() -> void:
	text_write = Autoplay.NONE
	inc_line(-1)
	$VBoxContainer/ColorRect/MarginContainer/Text.visible_characters = -1

func _on_button_next_pressed() -> void:
	match(text_write):
		Autoplay.NONE:
			inc_line()
		Autoplay.WRITE:
			text_write = Autoplay.NONE
			$VBoxContainer/ColorRect/MarginContainer/Text.visible_characters = -1
		Autoplay.AUTO:
			text_write = Autoplay.NONE
			$VBoxContainer/ColorRect/MarginContainer/Text.visible_characters = -1

func _on_button_skip_pressed() -> void:
	pass

func _on_button_fast_forward_pressed() -> void:
	pass

func _on_button_autoplay_pressed() -> void:
	text_write = Autoplay.AUTO

func _on_button_hide_pressed() -> void:
	$VBoxContainer.visible = false

func _on_button_repeat_pressed():
	text_write = Autoplay.NONE
	display_line()
