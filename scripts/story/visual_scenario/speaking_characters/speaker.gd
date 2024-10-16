@tool
class_name SpeakerSetup
extends Resource


enum ActionWithSpeaker { ADD, CHANGE, REMOVE }

@export var action: ActionWithSpeaker = ActionWithSpeaker.ADD
@export var speaker: SpeakingCharacter :
	set(value):
		speaker = value
		notify_property_list_changed()
@export var current_emotion: SpeakingCharacter.CharacterEmotions
@export var is_looks_to_right: bool = false
@export_range(10, 90, 10, "suffix:%") var speaker_position_by_x: int = 30


func _validate_property(property: Dictionary) -> void:
	if property.name == "current_emotion":
		if speaker == null:
			property.usage |= PROPERTY_USAGE_READ_ONLY
		else:
			property.hint_string = ",".join(speaker.emotions)
