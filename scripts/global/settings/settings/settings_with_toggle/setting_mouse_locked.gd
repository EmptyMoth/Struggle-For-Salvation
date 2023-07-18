class_name SettingMouseLocked
extends BaseSettingsWithToggle


func _init() -> void:
	super("mouse_locked", false)


func _execute() -> void:
	DisplayServer.mouse_set_mode(
		DisplayServer.MOUSE_MODE_CONFINED 
		if is_on 
		else DisplayServer.MOUSE_MODE_VISIBLE
	)
