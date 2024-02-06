class_name KeywordsRichTextLabel
extends RichTextLabel


func _ready() -> void:
	bbcode_enabled = true
	set_keywords_text(text)


func _make_custom_tooltip(for_text: String) -> Object:
	return KeywordToolip.create_custom_tooltip(Keywords.KEYWORDS_BY_WORDS[for_text])


func set_keywords_text(new_text: String) -> void:
	text = new_text.format(Keywords.HINT_BY_WORDS)
