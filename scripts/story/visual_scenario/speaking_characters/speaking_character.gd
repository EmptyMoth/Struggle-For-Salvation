class_name SpeakingCharacter
extends Resource


enum CharacterEmotions {
	NORMAL,
	SURPRISE,
	JOY,
	ANGER,
	FEAR,
	SADNESS,
	DESPAIR,
}

@export var name_character: String
@export var sprite: Texture2D
@export_enum("Normal", "Surprise", "Joy", "Anger", "Fear", "Sadness", "Despair") \
		var emotions: Array[String] = ["NORMAL"]
