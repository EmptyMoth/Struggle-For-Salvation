class_name SettingVSync
extends BaseSettingsWithToggle


func _init() -> void:
	super("vsync", true)


func _execute() -> void:
	DisplayServer.window_set_vsync_mode(
		DisplayServer.VSYNC_ADAPTIVE
		if is_on
		else DisplayServer.VSYNC_DISABLED
	)
