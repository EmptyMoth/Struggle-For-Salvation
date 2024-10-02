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
@export_range(0, 100, 5, "suffix:%") var speaker_position_by_x: int


func _validate_property(property: Dictionary) -> void:
	if property.name == "current_emotion":
		if speaker == null:
			property.usage |= PROPERTY_USAGE_READ_ONLY
		else:
			property.hint_string = ",".join(speaker.emotions)
