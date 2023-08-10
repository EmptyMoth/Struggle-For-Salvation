class_name SkillSelectedButton
extends AspectRatioContainer


signal skill_selected(skill: BaseSkill)

var setted_skill: BaseSkill = null

@onready var _skill_selected_button: Button = $SkillSelectedButton
@onready var _cooldown_icon: TextureRect = $CooldownIcon
@onready var _counter_label: Label = $Counter


func _ready() -> void:
	var action_dice_list: Array[AbstractActionDice] = [AbstractActionDice.new(), AbstractActionDice.new()]
	action_dice_list[1].dice_type = AbstractActionDice.DiceType.EVADE_DICE
	var skill: BaseSkill = BaseSkill.new()
	skill.action_dice_list = action_dice_list
	set_skill(skill)


func set_skill(skill: BaseSkill) -> void:
	setted_skill = skill
	var skill_is_blocked: bool = skill.is_blocked()
	#_skill_selected_button.icon = skill.icon
	_skill_selected_button.disabled = skill_is_blocked
	match skill.application_type:
		BaseSkill.ApplicationType.COOLDOWN:
			_cooldown_icon.visible = skill_is_blocked
			_counter_label.visible = skill_is_blocked
			_counter_label.text = str(skill.application_type_count)
		BaseSkill.ApplicationType.USES:
			_cooldown_icon.hide()
			_counter_label.show()
			_counter_label.text = "x%s" % str(skill.application_type_count)


func _on_skill_selected_button_pressed() -> void:
	emit_signal("skill_selected", setted_skill)
