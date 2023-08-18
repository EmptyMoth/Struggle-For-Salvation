class_name AbstractSkillStats
extends Resource


enum RangeType { MELEE, RANGE, MASS_SUMMATION, MASS_INDIVIDUAL }
#enum ApplicationType { USES, COOLDOWN }

@export var icon: Texture2D = Texture2D.new()
@export_multiline var title: String = ""
@export var range_type: RangeType = RangeType.MELEE
#@export var application_type: ApplicationType = ApplicationType.COOLDOWN
#@export_range(1, 10, 1, "or_greater") var application_type_count: int = 1
@export var ability: AbstractAbility = NoAbility.new()
@export var action_dice_list: Array[AbstractActionDice] = []


func _init(
		_title: String, 
		_range_type: RangeType, 
		_action_dice_list: Array[AbstractActionDice],
		_icon: Texture2D,
		_ability: AbstractAbility = NoAbility.new()) -> void:
	icon = _icon
	title = _title
	range_type = _range_type
	action_dice_list = _action_dice_list
	ability = _ability
