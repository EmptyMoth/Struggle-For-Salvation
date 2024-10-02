@tool
extends TextureRect


@export_color_no_alpha var _body_color: Color
@export_color_no_alpha var _accent_default_color: Color
@export_color_no_alpha var _accent_selected_color: Color

@onready var _border: TextureRect = $Border
@onready var _icon: TextureRect = $Icon
@onready var _skill_icon: TextureRect = $SkillIcon


func _ready() -> void:
	_body_color.a = 0.9
	self_modulate = _body_color
	to_default()


func to_default() -> void:
	_border.self_modulate = _accent_default_color
	_icon.self_modulate = _accent_default_color


func to_selected() -> void:
	_border.self_modulate = _accent_selected_color
	_icon.self_modulate = _accent_selected_color


func _on_installed_skill_changed(new_skill: Skill) -> void:
	var is_skill: bool = new_skill != null
	_icon.visible = not is_skill
	_skill_icon.visible = is_skill
	if is_skill:
		_skill_icon.texture = new_skill.stats.icon
