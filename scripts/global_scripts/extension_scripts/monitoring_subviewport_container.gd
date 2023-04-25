class_name MonitoringSubViewportContainer
extends SubViewportContainer


@onready var viewport_initial_size: Vector2 = size
@onready var viewport: SubViewport = get_children().front()


func _ready():
	get_viewport().size_changed.connect(_root_viewport_size_changed)


func _root_viewport_size_changed():
	size = get_viewport().size
	#viewport_sprite.scale = viewport_initial_size.y / get_viewport().size.y
