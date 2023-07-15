class_name LoadingScreen
extends CanvasLayer


var target_scene_path: String = ""
var progress: Array[float] = [0.0]

@onready var progress_bar: ProgressBar = $ProgressBar


func _process(_delta: float) -> void:
	var loading_status: ResourceLoader.ThreadLoadStatus = \
			ResourceLoader.load_threaded_get_status(target_scene_path, progress)
	
	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			progress_bar.value = 100 * progress[0]
		ResourceLoader.THREAD_LOAD_LOADED:
			var resource: Resource = ResourceLoader.load_threaded_get(target_scene_path)
			get_tree().change_scene_to_packed(resource)
		_:
			print("Error. Could not load Resource")


func start_loading(scene_path: String) -> void:
	target_scene_path = scene_path
	var loader: Error = ResourceLoader.load_threaded_request(target_scene_path)
	if loader != OK:
		print("error occured while getting the scene")
		return
