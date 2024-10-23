class_name BaseLocation
extends Node2D


#@export var packed_background: PackedScene
#@export var packed_battlefield: PackedScene

var background: ParallaxBackground = null :
	set(value): background = value
	get: return background
var battlefield: BaseBattlefield = null :
	set(value): battlefield = value
	get: return $Battlefield/BattlefieldViewport.get_child(0)

@onready var _darkening_screen: ColorRect = $DarkeningScreen


func _ready() -> void:
	pass
	#battlefield = get_node("Battlefield/BattlefieldViewport/Battlefield")
	#_initialize_background()
	#_initialize_battlefield()
	#_initialize_camera()


func darken(is_darken: bool) -> void:
	get_tree().create_tween().tween_property(
		_darkening_screen, "modulate", Color(1, 1, 1, 0 if is_darken else 1), 0.2)


#func _initialize_background() -> void:
	#background = packed_background.instantiate()
	#background.name = "Background"
	##add_child(background)
#
#func _initialize_battlefield() -> void:
	#battlefield = packed_battlefield.instantiate()
	#battlefield.name = "Battlefield"
	#$Battlefield/BattlefieldViewport.add_child(battlefield)

func _initialize_camera() -> void:
	pass
	#($Camera as BattleCamera).position = Vector2(1920/2, 1080/2)
