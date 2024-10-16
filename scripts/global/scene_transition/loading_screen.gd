class_name LoadingScreen
extends CanvasLayer


static var _LOCATIONS_DATA_BY_LOCAIONS: Array[LocationData] = [
	LocationData.new("BRAIN_STEM", Color("DAD07A")),
	LocationData.new("LUNGS", Color("5AF7C8")),
	LocationData.new("VESSELS", Color("E83E36")),
	LocationData.new("LYMPH", Color("337D36")),
	LocationData.new("MUCOUS", Color("89EBAA")),
	LocationData.new("EPIDERMIS", Color("7D51DC")),
	LocationData.new("BOWELS", Color("32AADA")),
	LocationData.new("STOMACH", Color("ED942B")),
]

var target_scene_path: String = ""
var progress: Array[float] = [0.0]

@onready var _progress_label: Label = $Margin/VBox/LoadingProgress/Progress


func _ready() -> void:
	_set_last_location()


func _process(_delta: float) -> void:
	var loading_status: ResourceLoader.ThreadLoadStatus = \
			ResourceLoader.load_threaded_get_status(target_scene_path, progress)
	match loading_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			_progress_label.text = "%s%%" % str(int(100 * progress[0]))
		ResourceLoader.THREAD_LOAD_LOADED:
			var resource: Resource = ResourceLoader.load_threaded_get(target_scene_path)
			get_tree().change_scene_to_packed(resource)
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			assert(false, "Error. Incorrect resource: " + target_scene_path)
		ResourceLoader.THREAD_LOAD_FAILED:
			assert(false, "Error. Could not load scene: " + target_scene_path)


func start_loading(scene_path: String) -> void:
	target_scene_path = scene_path
	var loader: Error = ResourceLoader.load_threaded_request(target_scene_path)
	if loader != OK:
		assert(false, "Error occured while getting the scene: " + scene_path)


func _set_last_location() -> void:
	var last_location: GlobalEnums.Locations = GlobalEnums.Locations.values().pick_random()
	var location_name: String = GlobalEnums.Locations.find_key(last_location).to_lower()
	location_name = GlobalParameters.FOLDER_WITH_LOCATION_TEXTURE + location_name + ".png"
	var texture: CompressedTexture2D = load(location_name)
	$LastLocation/Location.texture = texture
	_set_location_name(last_location)


func _set_location_name(location: GlobalEnums.Locations) -> void:
	var label: Label = $LastLocation/LocationName
	_LOCATIONS_DATA_BY_LOCAIONS[location].set_data_in_label(label)
	get_tree().create_tween().\
			set_ease(Tween.EASE_OUT).\
			set_trans(Tween.TRANS_QUINT).\
			tween_property(label, "position:x", 556, 1).from(300)


class LocationData:
	var title: String
	var color: Color
	
	func _init(_title: String, _color: Color) -> void:
		title = _title
		color = _color
	
	func set_data_in_label(label: Label) -> void:
		label.text = title
		label.modulate = color
