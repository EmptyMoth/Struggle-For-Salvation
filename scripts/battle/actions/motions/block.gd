class_name Block
extends Knockback


static func _static_init() -> void:
	DEFAULT = Block.new()


func _init() -> void:
	super(1, 0.3, BattleEnums.CharactersMotions.BLOCK, false)
