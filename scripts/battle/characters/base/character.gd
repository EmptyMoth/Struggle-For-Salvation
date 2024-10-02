class_name Character
extends Node2D


#signal fraction_changed(new_fraction: BattleEnums.Fraction)
signal died
signal stunned
signal came_out_of_stun
signal started_performing_action
signal finished_performing_action
signal taken_damage(damage_info: DamageInfo)
signal taken_physical_damage(damage_info: DamageInfo)
signal taken_mental_damage(damage_info: DamageInfo)

@export var stats: CharacterStats
var view_model: CharacterViewModel = CharacterViewModel.new(self)
var combat_model: CharacterCombatModel = CharacterCombatModel.new(self)
var movement_model: CharacterMovementModel = preload("res://scenes/battle/characters/base/character_movement_model.tscn").instantiate()

var is_ally: bool :
	get: return fraction == BattleEnums.Fraction.ALLY
var is_dead: bool :
	get: return character_fsm.current_state is DeathState
var is_stunned: bool :
	get: return character_fsm.current_state is StunState
var is_active: bool:
	get: return not (is_stunned or is_dead)
var independently_arranges_skills : bool

var team: BaseTeam
var fraction: BattleEnums.Fraction :
	get: return team.team_fraction if team != null else BattleEnums.Fraction.ALLY
var atp_slots_manager: ATPSlotsManager
var character_fsm: CharacterFSM

var physical_health: BaseHealth :
	get: return health_manager.physical_health
var mental_health: BaseHealth :
	get: return health_manager.mental_health
var physical_resistance: BaseResistance :
	get: return health_manager.physical_resistance
var mental_resistance: BaseResistance :
	get: return health_manager.mental_resistance

@onready var skills_manager := SkillsManager.new(self, stats.skills)
@onready var health_manager := HealthManager.new(self)
@onready var status_effects_manager := StatusEffectsManager.new(self)


func init(character_stats: CharacterStats, new_team: BaseTeam) -> void:
	stats = character_stats
	team = new_team
	#_targets_setter = battle_parameters.auto_assault_setter


func _ready() -> void:
	add_child(view_model)
	movement_model.model = self
	character_fsm = CharacterFSM.new(self)
	atp_slots_manager = ATPSlotsManager.new(self, view_model.atp_slots_manager_ui)
	_set_character_to_groups()
	for ability: BaseCharacterAbility in stats.passive_abilities:
		ability.init(self)


func _process(_delta: float) -> void:
	view_model.character_motions.scale = Vector2.ONE * (1.5 + movement_model.position.z / 5.0)
	position = movement_model.get_current_position_on_camera()


func _to_string() -> String:
	return stats.name


func get_movement_model() -> CharacterMovementModel: return movement_model

func get_slots_for_assaults() -> Array[ATPSlot]: return atp_slots_manager.get_atp_slots_for_assaults()

func get_slots_available_for_targeting() -> Array[ATPSlot]: return atp_slots_manager.get_atp_slots_available_for_targeting()


func to_die() -> void: health_manager.to_die()

func to_stun() -> void: health_manager.to_stun()


func make_independent() -> void:
	independently_arranges_skills = true

func remove_independent() -> void:
	independently_arranges_skills = false


func start_performing_action() -> void:
	started_performing_action.emit()

func finish_performing_action() -> void:
	finished_performing_action.emit()


func prepare_character() -> void:
	if is_dead:
		return
	movement_model.set_to_default_position()
	view_model.prepare_character()
	status_effects_manager.reduce_effects_stack()
	atp_slots_manager.preparation_atp_slots()
	if is_active:
		atp_slots_manager.roll_atp_slots()
		skills_manager.restore_skills()


func prepare_character_to_combat() -> void:
	if is_dead:
		return
	view_model.prepare_character_to_combat()


func auto_set_assault(opponents: Array[Character]) -> void:
	if not is_active:
		return
	for atp_slot: ATPSlot in get_slots_for_assaults():
		var skill: Skill = skills_manager.auto_selects_skill_or_null()
		if skill == null:
			return
		var targets_setter: BaseTargetsSetter = \
				skill.get_targets_setter() if skill.get_targets_setter() else stats.targets_setter
		var targets: Targets = AutoTargetsSetter.choose_targets(
				opponents, skill.targets_count, targets_setter)
		AssaultSetter.create_assault(atp_slot, targets, skill)


func _set_character_to_groups() -> void:
	add_to_group(BattleGroups.CHARACTERS_GROUP)
	add_to_group(BattleGroups.GROUPS_BY_FRACTIONS[fraction])
	add_to_group(BattleGroups.GROUPS_BY_CHARACTERS_TYPES[stats.type])
	if stats.type != BattleEnums.CharacterType.IMMUNOCYTE:
		add_to_group(BattleGroups.PATHOGENS_GROUP)
