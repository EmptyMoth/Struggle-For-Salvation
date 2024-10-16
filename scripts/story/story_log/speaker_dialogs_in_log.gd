class_name SpeakerDialogsLog
extends HBoxContainer


func set_speaker(speaker: SpeakingCharacter, dialogs: PackedStringArray) -> void:
	($SpeakerName as Label).text = "%s:" % speaker.name_character
	($Dialogs as KeywordsRichTextLabel).set_keywords_text("\n\n".join(dialogs))
