class_name ConfigHandler
extends Control


var _config: ConfigFile
var _path: String


func _init(path: String, values: Array = [], force_blank: bool = false) -> void:
	_config = ConfigFile.new()
	if not force_blank:
		load_config(path)
	if not values == []:
		validate_config(values)


func validate_config(targets: Array) -> void:
	for t in targets:
		validate_value(t[0], t[1], t[2])


func load_config(path: String) -> void:
	_path = path
	if _config.load(path) != OK:
		_config = ConfigFile.new()


func validate_value(section: String, key: String, value) -> void:
	if not _config.has_section_key(section, key):
		_config.set_value(section, key, value)


func save_config() -> void:
	@warning_ignore("return_value_discarded")
	_config.save(_path)


func get_value(section: String, key: String) -> Variant:
	return _config.get_value(section, key)


func set_value(section: String, key: String, value: Variant) -> void:
	_config.set_value(section, key, value)
