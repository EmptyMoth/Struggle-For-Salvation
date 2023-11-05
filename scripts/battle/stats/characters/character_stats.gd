class_name CharacterStats
extends Resource


@export var name: String = ''
@export var type: BattleEnums.CharacterType = BattleEnums.CharacterType.IMMUNOCYTE
@export var icon: Texture

@export var skills: Array[SkillStats] = []
@export var passive_abilities: Array[BaseCharacterPassiveAbility] = []

@export_group("Health")
@export_range(1, 999, 1, "or_greater") var max_physical_health: int = 1
@export_range(1, 999, 1, "or_greater") var max_mental_health: int = 1

@export_group("Resistances")
@export var physical_resistance: BaseResistance.Resistance = BaseResistance.Resistance.NORMAL
@export var mental_resistance: BaseResistance.Resistance = BaseResistance.Resistance.NORMAL

@export_group("ATP Slots")
@export_range(1, 10, 1, "or_greater") var atp_slots_count: int = 1
@export_range(1, 99, 1, "or_greater") var min_speed: int = 1
@export_range(1, 99, 1, "or_greater") var max_speed: int = 1

@export_category("Other")
@export var targets_setter: BaseTargetsSetter = null


func has_ability() -> bool:
	return passive_abilities.size() > 0
