class_name PopupWithCharacterAdditionalInfo
extends MovingContainer


signal skill_selected(skill: Skill)
signal skill_shown(skill: Skill)
signal skill_hidden(skill: Skill)

const PRESSET_FOR_PASSIVE_LIST: String = "[ul bullet=▪]\n%s[/ul]"
const PRESSET_FOR_PASSIVE_DESCRIPTION: String = "[color=#3AF][/color]%s"

var _skill_selected_button_group: ButtonGroup = ButtonGroup.new()
var _option_button_group: ButtonGroup = ButtonGroup.new()
var _current_pressed_option_button: BaseButton

@onready var _skills_button: Button = $Panel/Margin/VBox/Options/HBox/SkillsButton
@onready var _passive_button: Button = $Panel/Margin/VBox/Options/HBox/PassiveButton
@onready var _content: TabContainer = $Panel/Margin/VBox/SmoothScroll/Margin/Content
@onready var _skills_list: GridContainer = $Panel/Margin/VBox/SmoothScroll/Margin/Content/SkillsList
@onready var _passive_abilities_list: RichTextLabel = $Panel/Margin/VBox/SmoothScroll/Margin/Content/PassiveAbilitiesList
@onready var _scroll_container: Control = $Panel/Margin/VBox/SmoothScroll
@onready var _content_container_parent: Control = $Panel/Margin/VBox/SmoothScroll/Margin


func _ready() -> void:
	_skill_selected_button_group.pressed.connect(_on_skill_selected_button_group_pressed)
	_option_button_group.pressed.connect(_on_option_button_group_pressed)
	_skills_button.button_group = _option_button_group
	_passive_button.button_group = _option_button_group
	_minimize_popup()


func set_info(
			skills: Array[Skill], 
			passive_abilities: Array[BaseCharacterPassiveAbility]) -> void:
	_set_skills(skills)
	_set_passive_abilities(passive_abilities)
	_passive_button.visible = passive_abilities.size() > 0
	_minimize_popup()


func open_skills_list() -> void:
	_skills_button.button_pressed = true


func open_passive_abilities_list() -> void:
	if _passive_button.visible:
		_passive_button.button_pressed = true


func _minimize_popup() -> void:
	if _current_pressed_option_button != null:
		_current_pressed_option_button.button_pressed = false
		_current_pressed_option_button = null
	_scroll_container.hide()


func _set_passive_abilities(passives_abilities: Array) -> void:
	var passives_description: String = AbstractAbility.get_abilities_description(
			passives_abilities, PRESSET_FOR_PASSIVE_DESCRIPTION)
	_passive_abilities_list.text = PRESSET_FOR_PASSIVE_LIST % passives_description


func _set_skills(skills: Array[Skill]) -> void:
	_create_skill_selected_buttons(skills.size() - _skills_list.get_child_count())
	for i: int in skills.size():
		var skill: Skill = skills[i]
		var skill_selected_button: SkillSelectedButton = _skills_list.get_child(i)
		skill_selected_button.set_skill(skill)
	for i: int in range(skills.size(), _skills_list.get_child_count()):
		var skill_selected_button: SkillSelectedButton = _skills_list.get_child(i)
		skill_selected_button.remove_skill()


func _create_skill_selected_buttons(count: int) -> void:
	if count <= 0:
		return
	
	var skill_selected_button_scene: Resource = preload("res://scenes/ui/battle/popup_with_character_info/popup_with_character_additional_info/components/skill_selected_button.tscn")
	for i: int in count:
		var skill_selected_button: SkillSelectedButton = skill_selected_button_scene.instantiate()
		skill_selected_button.button_group = _skill_selected_button_group
		skill_selected_button.skill_shown.connect(_on_skill_selected_button_skill_shown)
		skill_selected_button.skill_hidden.connect(_on_skill_selected_button_skill_hidden)
		_skills_list.add_child(skill_selected_button)


func _on_option_button_group_pressed(button: BaseButton) -> void:
	if _current_pressed_option_button == button:
		_minimize_popup()
		return
	
	_current_pressed_option_button = button
	_content.current_tab = button.get_meta("content_index")
	_scroll_container.show()
	await get_tree().process_frame
	_scroll_container.custom_minimum_size.y = min(_content_container_parent.size.y, 220)


func _on_skill_selected_button_group_pressed(button: BaseButton) -> void:
	if button is SkillSelectedButton:
		if button.setted_skill.wearer.is_ally:
			@warning_ignore("static_called_on_instance")
			PlayerInputManager.on_ally_skill_selected(button.setted_skill)
		skill_selected.emit(button.setted_skill)


func _on_skill_selected_button_skill_shown(skill: Skill) -> void:
	skill_shown.emit(skill)

func _on_skill_selected_button_skill_hidden(skill: Skill) -> void:
	skill_hidden.emit(skill)
