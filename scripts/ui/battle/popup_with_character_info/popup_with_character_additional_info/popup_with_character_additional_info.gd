class_name PopupWithCharacterAdditionalInfo
extends PanelContainer


signal skill_selected(skill: BaseSkill) 

const SKILL_SELECTED_BUTTON_SCENE: PackedScene = preload("res://scenes/ui/battle/popup_with_character_info/popup_with_character_additional_info/components/skill_selected_button.tscn")
const PRESSET_FOR_PASSIVE_LIST: String = "[ul bullet=▪]\n%s[/ul]"
const PRESSET_FOR_PASSIVE_DESCRIPTION: String = "[color=#3AF][/color]%s"

@onready var _skills_button: Button = $Margin/VBox/Options/HBox/SkillsButton
@onready var _passive_button: Button = $Margin/VBox/Options/HBox/PassiveButton
@onready var _content: TabContainer = $Margin/VBox/SmoothScroll/Margin/Content
@onready var _skills_list: GridContainer = $Margin/VBox/SmoothScroll/Margin/Content/SkillsList
@onready var _passive_abilities_list: RichTextLabel = $Margin/VBox/SmoothScroll/Margin/Content/PassiveAbilitiesList
@onready var _content_container_parent: Control = $Margin/VBox/SmoothScroll

var _current_pressed_content_button: BaseButton = _skills_button


func _ready() -> void:
	_skills_button.button_group.pressed.connect(_on_button_group_pressed)
	_minimize_popup()


func set_info(
			skills: Array[BaseSkill], passive_abilities: Array[AbstractAbility]) -> void:
	
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
	_current_pressed_content_button.button_pressed = false
	_current_pressed_content_button = null
	_content_container_parent.hide()


func _set_skills(skills: Array[BaseSkill]) -> void:
	for skill in skills:
		var skill_selected_button = SKILL_SELECTED_BUTTON_SCENE.instantiate()
		_skills_list.add_child(skill_selected_button)
		skill_selected_button.set_skill(skill)


func _set_passive_abilities(passive_abilities: Array[AbstractAbility]) -> void:
	var passive_descriptions: PackedStringArray = PackedStringArray()
	for passive_ability in passive_abilities:
		passive_descriptions.append(PRESSET_FOR_PASSIVE_DESCRIPTION % passive_ability.description)
	
	var str_passive_list: String = "\n".join(passive_descriptions)
	_passive_abilities_list.text = PRESSET_FOR_PASSIVE_LIST % str_passive_list


func _on_button_group_pressed(button: BaseButton) -> void:
	if button == _current_pressed_content_button:
		_minimize_popup()
		return
	
	_current_pressed_content_button = button
	_content.current_tab = button.get_meta("content_index")
	_content_container_parent.show()


func _on_skill_selected_button_skill_selected(skill: BaseSkill) -> void:
	emit_signal("skill_selected", skill)
