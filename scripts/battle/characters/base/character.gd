class_name Character
extends Node2D


signal fraction_changed(new_fraction: BattleEnums.Fraction)

var stats: CharacterStats
var combat_model: CharacterCombatModel = CharacterCombatModel.new(self)
var view_model: CharacterViewModel = preload("res://scenes/battle/characters/base/abstract_character_view.tscn").instantiate()
var movement_model: CharacterMovementModel = preload("res://scenes/battle/characters/character_movement_model.tscn").instantiate()

var is_ally: bool :
	get: return fraction == BattleEnums.Fraction.ALLY
var is_dead: bool :
	get: return physical_health.is_empty()
var is_stunned: bool :
	get: return mental_health.is_empty()
var is_active: bool:
	get: return not is_stunned and not is_dead
var independently_arranges_skills : bool

var fraction: BattleEnums.Fraction
var atp_slots_manager: ATPSlotsManager

@onready var skills_manager: SkillsManager = SkillsManager.new(self, stats.skills)
@onready var physical_health: PhysicalHealth = PhysicalHealth.new(stats.max_physical_health)
@onready var mental_health: MentalHealth = MentalHealth.new(stats.max_mental_health)
@onready var physical_resistance: BaseResistance = BaseResistance.new(stats.physical_resistance)
@onready var mental_resistance: BaseResistance = BaseResistance.new(stats.mental_resistance)


func _init(battle_parameters: CharacterBattleParameters,
			character_fraction: BattleEnums.Fraction) -> void:
	y_sort_enabled = true
	stats = battle_parameters.stats
	fraction = character_fraction
	#_targets_setter = battle_parameters.auto_assault_setter


func _ready() -> void:
	view_model.set_model(self)
	add_child(view_model)
	atp_slots_manager = ATPSlotsManager.new(self, view_model.atp_slots_manager_ui)
	_set_character_to_groups()
	_connect_signals()


func _to_string() -> String:
	return stats.name


static func get_action_name(action: BattleParameters.CharactersMotions) -> String:
	var action_name: String = BattleParameters.CharactersMotions.find_key(action)
	return action_name.to_lower() if action_name != null else "default"


func get_movement_model() -> CharacterMovementModel:
	return movement_model


func get_slots_for_assaults() -> Array[ATPSlot]:
	return atp_slots_manager.get_atp_slots_for_assaults()

func get_slots_available_for_targeting() -> Array[ATPSlot]:
	return atp_slots_manager.get_atp_slots_available_for_targeting()


func make_independent() -> void:
	independently_arranges_skills = true

func remove_independent() -> void:
	independently_arranges_skills = false


func auto_set_assault(opponents: Array[Character]) -> void:
	for atp_slot: ATPSlot in get_slots_for_assaults():
		var skill: Skill = skills_manager.auto_selects_skill_or_null()
		if skill == null:
			return
		var targets_setter: BaseTargetsSetter = \
				skill.get_targets_setter() if skill.get_targets_setter() else stats.targets_setter
		var targets: Targets = AutoTargetsSetter.choose_targets(
				opponents, skill.targets_count, targets_setter)
		AssaultSetter.create_assault(atp_slot, targets, skill)


func take_damage(damage: int, is_permanent: bool = false) -> void:
	take_physical_damage(damage, is_permanent)
	take_mental_damage(damage, is_permanent)

func take_physical_damage(damage: int, is_permanent: bool = false) -> int:
	return _take_damage(damage, is_permanent, physical_resistance, physical_health)

func take_mental_damage(damage: int, is_permanent: bool = false) -> int:
	return _take_damage(damage, is_permanent, mental_resistance, mental_health)


func physical_heal(heal_amound: int) -> void:
	physical_health.heal(heal_amound)

func mental_heal(heal_amound: int) -> void:
	mental_health.heal(heal_amound)


func to_die() -> void:
	take_physical_damage(physical_health.max_health)

func to_stun() -> void:
	take_mental_damage(mental_health.max_health)


func _take_damage(damage: int, is_permanent: bool,
			resistance: BaseResistance, health: AbstractHealth) -> int:
	var final_damage: int = damage if is_permanent else roundi(damage * resistance.multiplier)
	health.take_damage(final_damage)
	return final_damage


func _set_character_to_groups() -> void:
	add_to_group(BattleGroups.CHARACTERS_GROUP)
	add_to_group(BattleGroups.GROUPS_BY_FRACTIONS[fraction])
	add_to_group(BattleGroups.GROUPS_BY_CHARACTERS_TYPES[stats.type])
	if stats.type != BattleEnums.CharacterType.IMMUNOCYTE:
		add_to_group(BattleGroups.PATHOGENS_GROUP)


func _connect_signals() -> void:
	physical_health.died.connect(_on_died)
	mental_health.stunned.connect(_on_stunned)
	for resistance: BaseResistance in [physical_resistance, mental_resistance]:
		mental_health.stunned.connect(resistance._on_character_stunned)
		mental_health.came_out_of_stun.connect(resistance._on_character_came_out_of_stun)


func _on_died() -> void:
	print("%s is DEAD!" % self)


func _on_stunned() -> void:
	print("%s is STUN!" % self)


func _on_battle_turn_started() -> void:
	movement_model.move_to_default_position()
	atp_slots_manager.preparation_atp_slots()
	if is_active:
		atp_slots_manager.roll_atp_slots()
		skills_manager.restore_skills()
