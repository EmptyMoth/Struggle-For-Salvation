extends Resource
class_name DialogueLine


const SPEAKERS_BY_NAMES: Dictionary = {
	"Нейтрофил 763": "Neut", 
	"Эозинофил 878": "Eosi", 
	"Эозинофил ???": "Eosi", 
	"Моноцит 309": "Mono", 
	"Моноцит ???": "Mono", 
	"Макрофаг": "Macrophage", 
	"Нейтрофил 480": "Neutrophil480", 
	"Нейтрофил ???": "Neutrophil",
	"Эритроцит 945": "Ery",
}


var speaker_name: String = ""
var speaker_role: String = ""
var line: String = ""
var speakers: Array


func _init(_speaker_name: String, _speaker_role: String, 
		_line: String, _speakers: Array) -> void:
	speaker_name = _speaker_name
	speaker_role = _speaker_role
	line = _line
	speakers = _speakers


func get_current_speaker() -> String:
	return SPEAKERS_BY_NAMES.get(speaker_name, "")
