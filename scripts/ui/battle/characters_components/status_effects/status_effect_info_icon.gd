class_name StatusEffectInfoIcon
extends TextureRect


@onready var _label_stack_count: Label = $StackCount


func _make_custom_tooltip(for_text: String) -> Object:
	return KeywordToolip.create_custom_tooltip(Keywords.KEYWORDS_BY_WORDS[for_text], _label_stack_count.text)


func set_info(status_effect: AbstractStatusEffect) -> void:
	status_effect.expired.connect(_on_status_effect_expired)
	status_effect.changed_stack_count.connect(_on_status_effect_changed_stack_count)
	texture = status_effect.get_icon()
	tooltip_text = status_effect.get_keyword()
	_label_stack_count.visible = status_effect is StackingStatusEffect
	if _label_stack_count.visible:
		_label_stack_count.text = str(status_effect.stack_count)


func _on_status_effect_changed_stack_count(new_stack_count: int) -> void:
	_label_stack_count.text = str(new_stack_count)


func _on_status_effect_expired(_status_effect: AbstractStatusEffect) -> void:
	queue_free()
