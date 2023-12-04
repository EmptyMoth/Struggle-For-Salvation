class_name ActionDiceCombatModel
extends Resource


signal destroyed
signal dice_used
signal used_in_one_side(target: Character)
signal won_clash(target: Character)
signal drew_clash(target: Character)
signal lost_clash(target: Character)

var model: ActionDice

var is_used_in_one_side: bool = false
var is_avoids_clash: bool = false

var is_used: bool = false
var is_reserved: bool = false
var is_recycled: bool = false
var is_destroyed: bool = false


func _init(dice: ActionDice) -> void:
	model = dice


func _to_string() -> String:
	return "%cD-" + str(model.values_model.get_current_value())


func break_dice() -> void:
	destroyed.emit()


func use_in_one_side(target: Character) -> void:
	is_used = true
	used_in_one_side.emit()
	dice_used.emit()


func use_in_clash(target: Character, clash_result: BattleEnums.ClashResult) -> void:
	match clash_result:
		BattleEnums.ClashResult.WIN:
			_win_clash(target)
		BattleEnums.ClashResult.LOSE:
			_lose_clash(target)
		_:
			_draw_clash(target)
	dice_used.emit()
	is_used = true


func _win_clash(target: Character) -> void:
	won_clash.emit(target)

func _draw_clash(target: Character) -> void:
	drew_clash.emit(target)

func _lose_clash(target: Character) -> void:
	lost_clash.emit(target)
