class_name CooldownSkillStats
extends AbstractSkillStats


@export_range(1, 9, 1, "or_greater", "suffix:turn") var cooldown: int = 1


func _init(
		_title: String,
		_range_type: RangeType,
		_cooldown: int,
		_action_dice_list: Array[AbstractActionDice],
		_icon: Texture2D,
		_ability: AbstractAbility = NoAbility.new()) -> void:
	cooldown = _cooldown
	super(_title, _range_type, _action_dice_list, _icon, _ability)
