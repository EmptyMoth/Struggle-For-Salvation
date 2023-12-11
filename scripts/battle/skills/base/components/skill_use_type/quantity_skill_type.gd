class_name QuantitySkillType
extends AbstractSkillUseType


var quantity: int

var _data: QuantityData


func _init(data: AbstractSkillUseTypeData) -> void:
	if not data is QuantityData:
		push_error("attempt to install data not related to quantity skill type")
	_data = data as QuantityData
	quantity = data.quantity


func is_available() -> bool:
	return quantity > 0


func select() -> void:
	quantity -= 1

func deselect() -> void:
	quantity += 1


func restore() -> void:
	quantity = _data.quantity
