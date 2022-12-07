extends VBoxContainer
class_name LogEntry

var speaker_name: RichTextLabel# = $Name
var speaker_line: RichTextLabel# = $Speech

func _ready():
	pass

func init(role: String, name: String, line: String):
	speaker_name = $Name
	speaker_line = $Speech
	if(role != ""):
		speaker_name.text = role + ", " + name + ":"
	else:
		speaker_name.text = name + ":"
	speaker_line.text = line
