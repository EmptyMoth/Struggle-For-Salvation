class_name ActionDiceReservedList
extends Resource


var dice_count: int :
	get: return _dice_reserved_list.size()

var _dice_reserved_list: Array[AbstractActionDice] = []


func there_is_reserved_dice() -> bool:
	return  dice_count > 0


func enqueue(dice: AbstractActionDice) -> void:
	_dice_reserved_list.append(dice)


func dequeue() ->  AbstractActionDice:
	return _dice_reserved_list.pop_front()
