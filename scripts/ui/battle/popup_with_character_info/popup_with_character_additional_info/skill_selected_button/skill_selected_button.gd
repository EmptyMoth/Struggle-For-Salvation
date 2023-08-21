class_name SkillSelectedButton
extends AspectRatioContainer


signal skill_selected(skill: AbstractSkill)

var setted_skill: AbstractSkill = null

@onready var _skill_selected_button: Button = $SkillSelectedButton
@onready var _cooldown_icon: TextureRect = $CooldownIcon
@onready var _counter_label: Label = $Counter


func set_skill(skill: AbstractSkill) -> void:
	setted_skill = skill
	var skill_is_blocked: bool = skill.is_blocked()
	_skill_selected_button.icon = skill.icon
	_skill_selected_button.disabled = skill_is_blocked
	if skill is CooldownSkill:
		_cooldown_icon.visible = skill_is_blocked
		_counter_label.visible = skill_is_blocked
		_counter_label.text = str(skill.application_type_count)
	elif skill is QuantitySkill:
		_cooldown_icon.hide()
		_counter_label.show()
		_counter_label.text = "x%s" % str(skill.application_type_count)


func _on_skill_selected_button_pressed() -> void:
	emit_signal("skill_selected", setted_skill)
