extends MarginContainer


@onready var _base_info: PopupWithCharacterBaseInfo = $HBox/VBox/PopupWithCharacterBaseInfo
@onready var _additional_info: PopupWithCharacterAdditionalInfo = $HBox/VBox/PopupWithCharacterAdditionalInfo
@onready var _skill_info: PopupWithSkillInfo = $HBox/PopupWithSkillInfo


func _ready() -> void:
	_additional_info.skill_selected.connect(_skill_info._on_skill_selected)


func set_info(character: AbstractCharacter, speed_dice: AbstractSpeedDice) -> void:
	_base_info.set_info(character)
	_additional_info.set_info(character.stats.skills, character.stats.passive_abilities)
	if speed_dice == null:
		_skill_info.hide()
		_additional_info.open_passive_abilities_list()
	else:
		_skill_info.set_info(speed_dice.installed_skill)
		_additional_info.open_skills_list()
