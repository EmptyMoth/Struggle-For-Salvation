class_name SkillSelectedButton
extends Button


signal skill_picked(self_skill_button: SkillSelectedButton)
signal skill_selected(self_skill_button: SkillSelectedButton)
signal skill_deselected(self_skill_button: SkillSelectedButton)

var setted_skill: Skill = null

@onready var _cooldown_icon: TextureRect = $CooldownIcon
@onready var _counter_label: Label = $Counter


func set_skill(skill: Skill) -> void:
	setted_skill = skill
	icon = skill.stats.icon
	disabled = not skill.is_available
	_set_cost(skill.use_type, skill.is_available)


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
	skill_selected.emit(self)
	PlayerInputManager.skill_selected.emit(setted_skill)

func _on_mouse_exited() -> void:
	skill_deselected.emit(self)
	PlayerInputManager.skill_deselected.emit(setted_skill)

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		skill_picked.emit(self)
		PlayerInputManager.skill_picked.emit(setted_skill)
