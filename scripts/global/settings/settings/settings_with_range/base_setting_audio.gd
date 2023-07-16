class_name BaseSettingAudio
extends BaseSettingWithRange


var bus_name: String = "Master"


func _init(_name: String, _bus_name: String) -> void:
	self.bus_name = _bus_name
	super(_name, 100, 0, 100, 1)


func _execute() -> void:
	var bus_index: int = AudioServer.get_bus_index(bus_name)
	var decibels: float = linear_to_db(value / float(max_value))
	AudioServer.set_bus_volume_db(bus_index, decibels)
