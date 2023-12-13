class_name HealthManager
extends Resource


var physical_health: BaseHealth
var mental_health: BaseHealth
var physical_resistance: BaseResistance :
	get: return physical_health.resistance
var mental_resistance: BaseResistance :
	get: return mental_health.resistance


func _init(character: Character) -> void:
	physical_health = BaseHealth.new(
			character.stats.max_physical_health, character.stats.physical_resistance)
	mental_health = BaseHealth.new(
			character.stats.max_mental_health, character.stats.mental_resistance)
	_connect_signals(character)


func take_damage(damage: int, type := BattleEnums.DamageType.Attack) -> void:
	take_physical_damage(damage, type)
	take_mental_damage(damage, type)

func take_physical_damage(damage: int, type := BattleEnums.DamageType.Attack) -> void:
	_take_damage(physical_health, damage, type)

func take_mental_damage(damage: int, type := BattleEnums.DamageType.Attack) -> void:
	_take_damage(mental_health, damage, type)


func physical_heal(heal_amound: int) -> void: physical_health.heal(heal_amound)

func mental_heal(heal_amound: int) -> void: mental_health.heal(heal_amound)


func to_die() -> void:
	take_physical_damage(physical_health.max_health)

func to_stun() -> void:
	take_mental_damage(mental_health.max_health)


func _take_damage(health: BaseHealth, damage: int, type: BattleEnums.DamageType = BattleEnums.DamageType.Attack) -> void:
	if type == BattleEnums.DamageType.Attack:
		health.take_damage(damage, false)
		return
	health.take_damage(damage, true)


func _connect_signals(character: Character) -> void:
	character.came_out_of_stun.connect(mental_health.recover)
	for resistance: BaseResistance in [physical_resistance, mental_resistance]:
		character.stunned.connect(resistance._on_character_stunned)
		character.came_out_of_stun.connect(resistance._on_character_came_out_of_stun)
