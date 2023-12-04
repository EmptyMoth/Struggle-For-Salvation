class_name CounterDice
extends OffensiveDice


func _init(dice: ActionDice) -> void:
	is_avoids_clash = true
	super(dice)


func _to_string() -> String:
	return super() % "C"
