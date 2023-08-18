class_name BaseSkill
extends Resource


enum RangeType { MELEE, RANGE, MASS_SUMMATION, MASS_INDIVIDUAL }
enum ApplicationType { USES, COOLDOWN }

@export var icon: Texture2D = Texture2D.new()
@export_multiline var title: String = ""
@export var range_type: RangeType = RangeType.MELEE
@export var application_type: ApplicationType = ApplicationType.COOLDOWN
@export_range(1, 10, 1, "or_greater") var application_type_count: int = 1
@export var ability: AbstractAbility = NoAbility.new()
@export var action_dice_list: Array[AbstractActionDice] = []


#static func get_str_application_type(skill: BaseSkill) -> String:
#	return "Uses" if skill.application_type == BaseSkill1.ApplicationType.USES else "Cooldown"


func is_blocked() -> bool:
	return application_type_count == 0
