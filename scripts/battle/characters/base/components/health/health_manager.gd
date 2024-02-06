class_name HealthManager
extends Resource


var physical_health: BaseHealth
var mental_health: BaseHealth
var physical_resistance: BaseResistance :
	get: return physical_health.resistance
var mental_resistance: BaseResistance :
	get: return mental_health.resistance

var _model: Character


func _init(character: Character) -> void:
	_model = character
	physical_health = BaseHealth.new(
			character.stats.max_physical_health, character.stats.physical_resistance)
	mental_health = BaseHealth.new(
			character.stats.max_mental_health, character.stats.mental_resistance)
	_connect_signals(character)


func take_damage(damage_info: DamageInfo) -> void:
	take_physical_damage(damage_info)
	take_mental_damage(damage_info)

func take_physical_damage(damage_info: DamageInfo) -> void:
	damage_info.damage_type = BattleEnums.DamageType.PHYSICAL
	_take_damage(physical_health, damage_info)
	_model.taken_physical_damage.emit(damage_info)

func take_mental_damage(damage_info: DamageInfo) -> void:
	damage_info.damage_type = BattleEnums.DamageType.MENTAL
	_take_damage(mental_health, damage_info)
	_model.taken_mental_damage.emit(damage_info)


func physical_heal(heal_amound: int) -> void: physical_health.heal(heal_amound)

func mental_heal(heal_amound: int) -> void: mental_health.heal(heal_amound)


func to_die() -> void:
	take_physical_damage(DamageInfo.new(
			physical_health.max_health, _model, BattleEnums.DamageSourceType.ABILITY))

func to_stun() -> void:
	take_mental_damage(DamageInfo.new(
			mental_health.max_health, _model, BattleEnums.DamageSourceType.ABILITY))


func _take_damage(health: BaseHealth, damage_info: DamageInfo) -> void:
	damage_info.damage_received = health.take_damage(
			damage_info.damage_source != BattleEnums.DamageSourceType.ATTACK, damage_info.damage_sent)
	_model.taken_damage.emit(damage_info)


func _connect_signals(character: Character) -> void:
	character.came_out_of_stun.connect(mental_health.recover)
	for resistance: BaseResistance in [physical_resistance, mental_resistance]:
		character.stunned.connect(resistance._on_character_stunned)
		character.came_out_of_stun.connect(resistance._on_character_came_out_of_stun)
