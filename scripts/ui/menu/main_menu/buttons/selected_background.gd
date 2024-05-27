class_name SelectedButtonBackground
extends VBoxContainer


static var _main_selected_gradient: GradientTexture1D
static var _main_unselected_gradient: GradientTexture1D
static var _lines_selected_gradient: GradientTexture1D
static var _lines_unselected_gradient: GradientTexture1D

@onready var _main: TextureRect = $MainBackground
@onready var _line_1: TextureRect = $Line1
@onready var _line_2: TextureRect = $Line2


static func _static_init() -> void:
	_main_selected_gradient = GradientTexture1D.new()
	_main_selected_gradient.gradient = preload("res://resources/ui/global/gradients/selected_background/main_selected.tres")
	_main_unselected_gradient = GradientTexture1D.new()
	_main_unselected_gradient.gradient = preload("res://resources/ui/global/gradients/selected_background/main_unselected.tres")
	_lines_selected_gradient = GradientTexture1D.new()
	_lines_selected_gradient.gradient = preload("res://resources/ui/global/gradients/selected_background/lines_selected.tres")
	_lines_unselected_gradient = GradientTexture1D.new()
	_lines_unselected_gradient.gradient = preload("res://resources/ui/global/gradients/selected_background/lines_unselected.tres")


func unselect() -> void:
	_line_1.texture = _lines_unselected_gradient
	_line_2.texture = _lines_unselected_gradient
	_main.texture = _main_unselected_gradient


func select() -> void:
	_line_1.texture = _lines_selected_gradient
	_line_2.texture = _lines_selected_gradient
	_main.texture = _main_selected_gradient
