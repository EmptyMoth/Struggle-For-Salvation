class_name ChapterZoomButton
extends TextureButton


@export var camera: PlayerCamera2D
@export var target: Node
#@export var target_location: Vector2 = Vector2.ZERO
@export var target_zoom: Vector2 = Vector2.ONE


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	camera.zoom_to(target.get_global_position() + target.size / 2, target_zoom)
