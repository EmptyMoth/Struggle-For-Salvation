class_name QuantitySkillStats
extends AbstractSkillStats


@export_range(1, 5, 1, "or_greater", "suffix:pcs") var quantity: int = 1


func _init(
		_title: String,
		_range_type: RangeType,
		_quantity: int,
		_action_dice_list: Array[AbstractActionDice],
		_icon: Texture2D,
		_ability: AbstractAbility = NoAbility.new()) -> void:
	quantity = _quantity
	super(_title, _range_type, _action_dice_list, _icon, _ability)
