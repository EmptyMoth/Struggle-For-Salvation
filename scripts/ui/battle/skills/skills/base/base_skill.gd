class_name BaseSkill
extends Resource


enum RangeType { MELEE, RANGE, MASS_SUMMATION, MASS_INDIVIDUAL }
enum UsesType { USES, COOLDOWN }

@export var icon: Texture2D = Texture2D.new()
@export_multiline var title: String = ""
@export var range_type: RangeType = RangeType.MELEE
@export var uses_type: UsesType = UsesType.COOLDOWN
@export_range(1, 10, 1, "or_greater") var uses_count_in_turn: int = 1
@export var ability: SkillAbility = null
@export var action_dice_list: Array[AbstractActionDice] = []


static func get_str_uses_type(skill: BaseSkill) -> String:
	return "Uses" if skill.uses_type == BaseSkill.UsesType.USES else "Cooldown"
