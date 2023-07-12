extends CanvasLayer


@onready var scene_transition: PackedScene = \
		preload("res://scenes/global_scenes/scene_transition.tscn")

var progress: Array[float] = [0.0] 


func change_scene_to_file(path: String) -> void:
	var loader: Error = ResourceLoader.load_threaded_request(path)
	if loader != OK:
		print("error occured while getting the scene")
		return
		


func change_scene_to_packed(packed_scene: PackedScene) -> void:
	get_tree().change_scene_to_packed(packed_scene)


func _process(_delta: float) -> void:
	var loading_status: ResourceLoader.ThreadLoadStatus = \
			ResourceLoader.load_threaded_get_status(target_scene_path, progress)
	
	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			progress_bar.value = 100 * progress[0]
		ResourceLoader.THREAD_LOAD_LOADED:
			var resource: Resource = ResourceLoader.load_threaded_get(path)
			get_tree().change_scene_to_packed(resource)
		_:
			print("Error. Could not load Resource")
