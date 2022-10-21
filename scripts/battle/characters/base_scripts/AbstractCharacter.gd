class_name AbstractCharacter
extends Node2D


enum Resistance {
	IMMUNITY = 0, 
	INEFFECTIVE = 50, 
	WEAK = 75,
	NORMAL = 100, 
	HIGH = 150, 
	FATAL = 200,
}

@export var name_character: String = ''
@export_range(1, 1000, 1) var max_physical_health: int = 1
@export_range(1, 1000, 1) var max_mental_health: int = 1
@export var physical_resistance: Resistance = Resistance.NORMAL
@export var mental_resistance: Resistance = Resistance.NORMAL

@export_range(1, 99, 1) var min_speed: int = 1
@export_range(1, 99, 1) var max_speed: int = 1
@export_range(1, 10, 1) var speed_dice_count: int = 1

@onready var physical_health: PhysicalHealth = PhysicalHealth.new(max_physical_health)
@onready var mental_health: MentalHealth = MentalHealth.new(max_mental_health)

@onready var subcharacter_bar: SubcharacterBars = $SubcharacterBars
@onready var actions_animations: AnimatedSprite2D = $Actions
@onready var speed_dice_manager: SpeedDiceManager = $SpeedDiceManager


func _ready() -> void:
	physical_health.died.connect(_on_died)
	mental_health.stunned.connect(_on_stunned)
	subcharacter_bar.init(physical_health, mental_health)
	
	speed_dice_manager.set_speed(min_speed, max_speed)
	speed_dice_manager.change_speed_dice_count(speed_dice_count)


func _process(_delta: float) -> void:
	#return
	var character_marker_3d: CharacterBody3D = $"../../../SubViewport/TestBattle"\
		.get_node("Characters/CharacterMarker3D")
	position = character_marker_3d.get_position_on_camera()


func roll_speed_dice() -> void:
	speed_dice_manager.roll_speed_dice()


func take_damage(damage: int) -> void:
	take_physical_damage(damage)
	take_mantal_damage(damage)


func take_physical_damage(damage: int) -> void:
	var physical_damage: int = roundi(damage * physical_resistance / 100.0)
	physical_health.decrease(physical_damage)


func take_mantal_damage(damage: int) -> void:
	var mental_damage: int = roundi(damage * mental_resistance / 100.0)
	mental_health.decrease(mental_damage)


func die() -> void:
	take_physical_damage(max_physical_health)


func stun() -> void:
	take_mantal_damage(max_mental_health)


func switch_view_direction() -> void:
	actions_animations.flip_h = !actions_animations.flip_h


func actions_switcher(action: BattleParameters.Action) -> void:
	match action:
		BattleParameters.Action.DEFAULT:
			actions_animations.play("default")
		BattleParameters.Action.STUN:
			actions_animations.play("stun")
		BattleParameters.Action.MOVEMENT:
			actions_animations.play("movement")
		BattleParameters.Action.BLOCK:
			actions_animations.play("block")
		BattleParameters.Action.EVADE:
			actions_animations.play("evade")
		BattleParameters.Action.SLASH_ATTACK:
			actions_animations.play("slash_attack")
		BattleParameters.Action.PIERCE_ATTACK:
			actions_animations.play("pierce_attack")
		BattleParameters.Action.BLUNT_ATTACK:
			actions_animations.play("blunt_attack")
		_:
			actions_animations.play("default")


func _on_died() -> void:
	pass


func _on_stunned() -> void:
	pass
