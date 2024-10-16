class_name TooltipPassiveDescription
extends Control


var is_fixed: bool = false

@export var _description: KeywordsRichTextLabel


func make_left_sided() -> void:
	$Margin/HBox.move_child($Margin/HBox/VTooltipSide, 0)
	$Margin/HBox/VTooltipSide.set_side(SIDE_LEFT)
	$Margin.add_theme_constant_override("margin_right", 0)
	$Margin.add_theme_constant_override("margin_left", 8)
	$Margin.position.x = 0
	$Margin/HBox/Margin/BorderLeft.hide()
	$Margin/HBox/Margin/BorderRight.show()


func set_description(text: String) -> void:
	_description.set_keywords_text(text)
