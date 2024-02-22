class_name TrainingScreen
extends Control


signal training_ended

const FIRST_ID_SLIDE: int = 1
const LAST_ID_SLIDE: int = 10

const _PATH_TO_SLIES: String = "res://sprites/ui/menu/training_screen/training_screen=%s.png"

@export var _is_manual: bool = false

var _from_id_slide: int
var _to_id_slide: int
var _current_id_slide: int

@onready var _training_slide: TextureRect = $Center/VBox/TrainingSlide
@onready var _back_button: Button = $Center/VBox/HBox/BackButton
@onready var _next_button: Button = $Center/VBox/HBox/NextButton


func _ready() -> void:
	$Shadow.visible = not _is_manual
	$Center/VBox/HBox/CloseButton.visible = _is_manual


func open_training(from_id_slide: int = FIRST_ID_SLIDE, to_id_slide: int = LAST_ID_SLIDE) -> void:
	show()
	_from_id_slide = from_id_slide
	_to_id_slide = to_id_slide
	_current_id_slide = from_id_slide
	_swap_slide()


func close_menu() -> void:
	_training_slide.texture = null
	hide()
	training_ended.emit()


func _swap_slide() -> void:
	_training_slide.texture = load(_PATH_TO_SLIES % str(_current_id_slide))
	_back_button.disabled = not (_current_id_slide != _from_id_slide)
	_next_button.disabled = not (not _is_manual or _current_id_slide != _to_id_slide)
	#_back_button.visible = _current_id_slide != _from_id_slide
	#_next_button.visible = not _is_manual or _current_id_slide != _to_id_slide
	_next_button.text = "CONTINUE" if not _is_manual and _current_id_slide == _to_id_slide else "NEXT"


func _on_next_button_pressed() -> void:
	if _current_id_slide >= _to_id_slide:
		if not _is_manual:
			close_menu()
		return
	_current_id_slide += 1
	_swap_slide()


func _on_back_button_pressed() -> void:
	_current_id_slide -= 1
	_swap_slide()


func _on_cancel_button_pressed() -> void:
	close_menu()
