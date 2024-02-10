class_name KeywordToolip
extends PanelContainer


const _TOOLTIP_PACKED_SCENE: PackedScene = preload("res://scenes/ui/base/tooltips/keywords_tooltip.tscn")


static func create_custom_tooltip(keyword: Keywords.Keyword, count: String = "N") -> KeywordToolip:
	var tooltip: KeywordToolip = _TOOLTIP_PACKED_SCENE.instantiate()
	tooltip.set_keyword(keyword, count)
	return tooltip


func set_keyword(keyword: Keywords.Keyword, count: String = "N") -> void:
	var _image: TextureRect = get_node("Margin/VBox/HBox/Image")
	var _title: Label = get_node("Margin/VBox/HBox/Title")
	var _description: RichTextLabel = get_node("Margin/VBox/DescriptionLabel")
	_image.visible = keyword.image != null
	if _image.visible:
		_image.texture = keyword.image
	_title.text = keyword.title
	_title.modulate = keyword.color
	_description.text = keyword.description.format(Keywords.HINT_BY_WORDS).format({"N": count})
