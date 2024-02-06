class_name SkillSelectedButton
extends Button


signal skill_shown(skill: Skill)
signal skill_hidden(skill: Skill)
signal skill_pressed(skill: Skill)

var setted_skill: Skill = null

@onready var _cooldown_icon: TextureRect = $CooldownIcon
@onready var _counter_label: Label = $Counter


func set_skill(skill: Skill) -> void:
	show()
	setted_skill = skill
	icon = skill.stats.icon
	disabled = not skill.is_available
	_set_cost(skill.use_type, skill.is_available)


func remove_skill() -> void:
	hide()
	setted_skill = null


func _set_cost(use_type: AbstractSkillUseType, skill_is_available: bool) -> void:
	if use_type is CooldownSkillType:
		_cooldown_icon.visible = not skill_is_available
		_counter_label.visible = not skill_is_available
		_counter_label.text = str(use_type.cooldown)
	else:
		_cooldown_icon.hide()
		_counter_label.show()
		_counter_label.text = "x%s" % str(use_type.quantity)


func _on_mouse_entered() -> void:
	skill_shown.emit(setted_skill)

func _on_mouse_exited() -> void:
	skill_hidden.emit(setted_skill)

func _on_pressed() -> void:
	skill_pressed.emit(setted_skill)
