extends HBoxContainer


@export var is_start_segment: bool = false


func _ready() -> void:
	if is_start_segment:
		$Point.custom_minimum_size = 20 * Vector2.ONE


func init(speed: int, color: Color) -> void:
	var line: ColorRect = $Line
	var point: TextureRect = $Point
	var speed_label: Label = $Point/Speed/Label
	line.modulate = color
	point.self_modulate = color
	speed_label.text = str(speed)
