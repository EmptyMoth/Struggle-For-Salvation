class_name Evade
extends Knockback


static func _static_init() -> void:
	DEFAULT = Evade.new()


func _init() -> void:
	super(2, 0.3, BattleEnums.CharactersMotions.EVADE, true, Tween.EASE_IN)
