class_name Block
extends Knockback


static var DEFAULT: Block = Block.new()


func _init() -> void:
	super(1, _DEFAULT_DURATION, BattleEnums.CharactersMotions.BLOCK)
