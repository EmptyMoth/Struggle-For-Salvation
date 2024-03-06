@tool
class_name EvadeMotion
extends KnockbackMotion


static var DEFAULT: EvadeMotion = EvadeMotion.new()


func _init() -> void:
	super(2, BattleEnums.CharactersMotions.EVADE, true, Tween.EASE_IN)
