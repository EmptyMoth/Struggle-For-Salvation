class_name TestStatusEffect
extends StackingStatusEffect


const _ICON_PATH: String = "res://sprites/battle/skills/test_skill_3.svg"
const _ICON: Texture2D = preload(_ICON_PATH)


static func get_tag() -> StatusEffectsList.Tags:
	return StatusEffectsList.Tags.TEST_EFFECT


static func get_keyword() -> String:
	return "TestStatusEffect"


static func get_icon_path() -> String:
	return _ICON_PATH


static func get_icon() -> Texture2D:
	return _ICON


func implement() -> void:
	wearer.health_manager.take_mental_damage(DamageInfo.new(
			stack_count, wearer, BattleEnums.DamageSourceType.STATUS_EFFECT))
