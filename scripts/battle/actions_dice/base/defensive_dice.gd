class_name DefensiveDice
extends ActionDiceCombatModel


signal defended

static var DEFAULT_ACTION: Action


func _init(dice: ActionDice) -> void:
	super(dice)
	action = dice.stats.action if dice.stats.action != null else DEFAULT_ACTION
