class_name Evade
extends Knockback


static var DEFAULT: Evade = Evade.new()


func _init() -> void:
	super(2, _DEFAULT_DURATION, BattleEnums.CharactersMotions.EVADE, true, Tween.EASE_IN)
