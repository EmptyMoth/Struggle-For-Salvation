class_name Keywords
extends RefCounted


static var HINT_BY_WORDS: Dictionary

static var KEYWORDS_BY_WORDS: Dictionary = {
	"TestWord": Keyword.new("Test Word", "Test title")
}


static func _static_init() -> void:
	for words: String in KEYWORDS_BY_WORDS:
		var keyword: Keyword = KEYWORDS_BY_WORDS[words]
		HINT_BY_WORDS[words] = _create_hint(words, keyword)


static func _create_hint(words: String, keyword: Keyword) -> String:
	#var hint: String = "[color=#%s][url=%s]%s[/url][/color]" \
	var hint: String = "[color=#%s][u][hint=%s]%s[/hint][/u][/color]" \
		% [keyword.color, words, keyword.title]
	var image_code: String = "" if keyword.image_path == "" else "[img=25x25]%s[/img] " \
		% [keyword.image_path]
	return image_code + hint


class Keyword:
	var title: String = ""
	var description: String = ""
	var color: String = ""
	var image_path: String = ""
	var image: CompressedTexture2D = null
	
	
	func _init(_title: String, _description: String, _color: String = "3af", _image_path: String = "") -> void:
		title = _title
		description = _description
		color = _color
		image_path = _image_path
		image = null if _image_path == "" else load(_image_path)
