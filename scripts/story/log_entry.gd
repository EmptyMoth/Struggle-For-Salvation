class_name LogEntry
extends VBoxContainer


var speaker_name: RichTextLabel
var speaker_line: RichTextLabel


func _ready():
	pass


func init(role: String, s_name: String, line: String):
	speaker_name = $Name
	speaker_line = $Speech
	speaker_name.text = "%s, %s:" % [role, s_name] if role else "%s:" % [s_name]
	speaker_line.text = line
