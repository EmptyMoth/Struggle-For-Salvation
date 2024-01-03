class_name BlockMotion
extends KnockbackMotion


static var DEFAULT: BlockMotion = BlockMotion.new()


func _init() -> void:
	super(1, DEFAULT_DURATION, BattleEnums.CharactersMotions.BLOCK)
