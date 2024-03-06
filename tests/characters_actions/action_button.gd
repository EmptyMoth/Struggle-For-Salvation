extends TextureButton


signal action_pressed(actions: Array[Action], is_mass_attack: bool)


@export var _actions: Array[Action] = []
@export var _is_mass_attack: bool = false


func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	action_pressed.emit(_actions, _is_mass_attack)
