class_name SkillSelectedButton
extends Button


signal skill_shown(skill: AbstractSkill)
signal skill_hidden(skill: AbstractSkill)

var setted_skill: AbstractSkill = null

@onready var _cooldown_icon: TextureRect = $CooldownIcon
@onready var _counter_label: Label = $Counter


func set_skill(skill: AbstractSkill) -> void:
	show()
	setted_skill = skill
	var skill_is_available: bool = skill.is_available()
	icon = skill.stats.icon
	disabled = not skill_is_available
	if skill is CooldownSkill:
		_cooldown_icon.visible = not skill_is_available
		_counter_label.visible = not skill_is_available
		_counter_label.text = str(skill.current_cooldown)
	elif skill is QuantitySkill:
		_cooldown_icon.hide()
		_counter_label.show()
		_counter_label.text = "x%s" % str(skill.current_quantity)


func remove_skill() -> void:
	hide()
	setted_skill = null


func _on_mouse_entered() -> void:
	skill_shown.emit(setted_skill)

func _on_mouse_exited() -> void:
	skill_hidden.emit(setted_skill)
