@tool
class_name BaseStoryScene
extends Resource


enum ApplyingEffect { ON_FULL_SCREEN, ON_SCREEN_WITHOUT_TEXT, ON_BACKGROUND }

@export_range(0, 100, 1, "or_greater") var id: int = 0
@export var location: StoryLocation = null
@export var speakers: Array[SpeakerSetup] = []

@export_group("Effects")
@export var effect_on_screen: Shader = null :
	set(value):
		effect_on_screen = value
		notify_property_list_changed()
@export var applying_effect: ApplyingEffect = ApplyingEffect.ON_FULL_SCREEN


func _validate_property(property: Dictionary) -> void:
	match property.name:
		"applying_effect":
			if effect_on_screen == null:
				property.usage |= PROPERTY_USAGE_READ_ONLY
