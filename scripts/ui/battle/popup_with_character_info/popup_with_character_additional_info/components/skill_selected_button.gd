class_name SkillSelectedButton
extends Button


signal skill_shown(skill: Skill)
signal skill_hidden(skill: Skill)

var setted_skill: Skill = null

@onready var _cooldown_icon: TextureRect = $CooldownIcon
@onready var _counter_label: Label = $Counter


func set_skill(skill: Skill) -> void:
	show()
	setted_skill = skill
	var skill_is_available: bool = skill.is_available
	icon = skill.stats.icon
	disabled = not skill_is_available
	if skill.stats.use_type is CooldownSkillType:
		_cooldown_icon.visible = not skill_is_available
		_counter_label.visible = not skill_is_available
		_counter_label.text = str(skill.current_use_count)#stats.use_type.current_cooldown)
	else:
		_cooldown_icon.hide()
		_counter_label.show()
		_counter_label.text = "x%s" % str(skill.current_use_count)#stats.use_type.current_quantity)


func remove_skill() -> void:
	hide()
	setted_skill = null


func _on_mouse_entered() -> void:
	skill_shown.emit(setted_skill)

func _on_mouse_exited() -> void:
	skill_hidden.emit(setted_skill)
