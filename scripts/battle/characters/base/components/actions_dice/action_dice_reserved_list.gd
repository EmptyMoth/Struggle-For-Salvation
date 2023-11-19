class_name ActionDiceReservedList
extends Resource


var dice_count: int :
	get: return _dice_reserved_list.size()

var _dice_reserved_list: Array[ActionDiceCombatModel] = []


func there_is_reserved_dice() -> bool:
	return  dice_count > 0


func get_dice() -> Array[ActionDiceCombatModel]:
	return _dice_reserved_list.duplicate()


func enqueue(dice: ActionDiceCombatModel) -> void:
	_dice_reserved_list.append(dice)
	dice.is_reserved = true


func dequeue() ->  ActionDiceCombatModel:
	return _dice_reserved_list.pop_front()
