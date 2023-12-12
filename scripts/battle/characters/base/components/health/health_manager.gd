class_name HealthManager
extends Resource


var physical_health: BaseHealth
var mental_health: BaseHealth
var physical_resistance: BaseResistance
var mental_resistance: BaseResistance


func _init(character: Character) -> void:
	physical_health = BaseHealth.new(character.stats.max_physical_health)
	mental_health = BaseHealth.new(character.stats.max_mental_health)
	physical_resistance = BaseResistance.new(character.stats.physical_resistance)
	mental_resistance = BaseResistance.new(character.stats.mental_resistance)
	_connect_signals(character)


func take_damage(damage: int, is_permanent: bool = false) -> void:
	take_physical_damage(damage, is_permanent)
	take_mental_damage(damage, is_permanent)

func take_physical_damage(damage: int, is_permanent: bool = false) -> int:
	return _take_damage(damage, is_permanent, physical_resistance, physical_health)

func take_mental_damage(damage: int, is_permanent: bool = false) -> int:
	return _take_damage(damage, is_permanent, mental_resistance, mental_health)


func physical_heal(heal_amound: int) -> void: physical_health.heal(heal_amound)

func mental_heal(heal_amound: int) -> void: mental_health.heal(heal_amound)


func to_die() -> void:
	take_physical_damage(physical_health.max_health)

func to_stun() -> void:
	take_mental_damage(mental_health.max_health)


func _take_damage(damage: int, is_permanent: bool,
			resistance: BaseResistance, health: BaseHealth) -> int:
	var final_damage: int = damage if is_permanent else roundi(damage * resistance.multiplier)
	health.take_damage(final_damage)
	return final_damage


func _connect_signals(character: Character) -> void:
	character.came_out_of_stun.connect(mental_health.recover)
	for resistance: BaseResistance in [physical_resistance, mental_resistance]:
		character.stunned.connect(resistance._on_character_stunned)
		character.came_out_of_stun.connect(resistance._on_character_came_out_of_stun)
