class_name TooltipSkillsSet
extends Control


#signal skill_selected(skill: Skill)
#signal skill_shown(skill: Skill)
#signal skill_hidden(skill: Skill)

var _SKILL_SELECTED_BUTTON_SCENE: PackedScene = preload("res://scenes/ui/battle/popup_character_info/popup_character_additional_info/components/skill_selected_button.tscn")

var is_fixed: bool = false
var func_get_position: Callable

var _skill_selected_button_group: ButtonGroup = ButtonGroup.new()

@onready var _skills_list: GridContainer = $Margin/VBox/Margin/Panel/Margin/GridContainer


func _ready() -> void:
	_skill_selected_button_group.pressed.connect(_on_skill_selected_button_group_pressed)


func _process(_delta: float) -> void:
	if visible:
		global_position = func_get_position.call()


#func make_top_sided() -> void:
	#add_theme_constant_override("margin_top", 8)
	#add_theme_constant_override("margin_bottom", 0)
	#$VBox.move_child($VBox/HTooltipSide, 0)
	#$VBox/HTooltipSide.set_side(SIDE_TOP)


func set_skills(skills: Array[Skill]) -> void:
	remove_skills(skills)
	add_skills(skills)
	#_create_skill_selected_buttons(skills.size() - _skills_list.get_child_count())
	#for i: int in skills.size():
		#var skill: Skill = skills[i]
		#var skill_selected_button: SkillSelectedButton = _skills_list.get_child(i)
		#skill_selected_button.set_skill(skill)
	#for i: int in range(skills.size(), _skills_list.get_child_count()):
		#var skill_selected_button: SkillSelectedButton = _skills_list.get_child(i)
		#skill_selected_button.remove_skill()


func remove_skills(skills: Array[Skill]) -> void:
	for skill: Node in _skills_list.get_children():
		_skills_list.remove_child(skill)


func add_skills(skills: Array[Skill]) -> void:
	for skill: Skill in skills:
		var skill_selected_button: SkillSelectedButton = _SKILL_SELECTED_BUTTON_SCENE.instantiate()
		skill_selected_button.button_group = _skill_selected_button_group
		#skill_selected_button.skill_shown.connect(_on_skill_selected_button_skill_shown)
		#skill_selected_button.skill_hidden.connect(_on_skill_selected_button_skill_hidden)
		#skill_selected_button.skill_pressed.connect(_on_skill_selected_button_skill_pressed)
		_skills_list.add_child(skill_selected_button)
		skill_selected_button.set_skill(skill)


#func _create_skill_selected_buttons(count: int) -> void:
	#if count <= 0:
		#return
	#for i: int in count:
		#var skill_selected_button: SkillSelectedButton = _SKILL_SELECTED_BUTTON_SCENE.instantiate()
		#skill_selected_button.button_group = _skill_selected_button_group
		#skill_selected_button.skill_shown.connect(_on_skill_selected_button_skill_shown)
		#skill_selected_button.skill_hidden.connect(_on_skill_selected_button_skill_hidden)
		#skill_selected_button.skill_pressed.connect(_on_skill_selected_button_skill_pressed)
		#_skills_list.add_child(skill_selected_button)


func _on_skill_selected_button_group_pressed(button: BaseButton) -> void:
	if button is SkillSelectedButton:
		if button.setted_skill.wearer.is_ally:
			PlayerArrangeAssaults.select_ally_skill(button.setted_skill)
		#skill_selected.emit(button.setted_skill)


#func _on_skill_selected_button_skill_shown(skill: Skill) -> void:
	#skill_shown.emit(skill)
#
#func _on_skill_selected_button_skill_hidden(skill: Skill) -> void:
	#skill_hidden.emit(skill)
#
#func _on_skill_selected_button_skill_pressed(skill: Skill) -> void:
	#if skill.wearer.is_ally:
		#PlayerArrangeAssaults.select_ally_skill(skill)
	#skill_selected.emit(skill)

