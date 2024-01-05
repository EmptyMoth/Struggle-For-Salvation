class_name TabsHeader
extends HBoxContainer


signal tab_changed(tab: int)
signal tab_collapse(tab: int)

@export var can_collapse_tabs: bool = false
@export var tab_container: TabContainer

var current_pressed_button: BaseButton

var _button_group: ButtonGroup = ButtonGroup.new()


func _ready() -> void:
	_button_group.pressed.connect(_on_option_button_group_pressed)
	var buttons: Array[BaseButton] = []
	buttons.assign(get_children())
	for button: BaseButton in buttons:
		button.button_group = _button_group


func collapse_current_tab() -> void:
	if not can_collapse_tabs:
		return
	current_pressed_button.button_pressed = false
	current_pressed_button = null


func _on_option_button_group_pressed(button: BaseButton) -> void:
	var current_tab: int = button.get_meta("content_index")
	if current_pressed_button == button:
		collapse_current_tab()
		tab_collapse.emit(current_tab)
		return
	current_pressed_button = button
	tab_container.current_tab = current_tab
	tab_changed.emit(current_tab)
