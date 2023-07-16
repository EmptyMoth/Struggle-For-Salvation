class_name SettingGraphicsQuality
extends BaseSettingWithOptions


func _init() -> void:
	_options = {
		"Low" = 0,
		"Medium" = 1,
		"High" = 2,
	}
	super("graphics_quality", "High", _options)


func _execute() -> void:
	pass
	#ProjectSettings.set_setting("rendering/camera/depth_of_field/depth_of_field_bokeh_shape", graphics_quality)
	#ProjectSettings.set_setting("rendering/camera/depth_of_field/depth_of_field_bokeh_quality", graphics_quality)
	#RenderingServer.viewport_set_occlusion_culling_build_quality(graphics_quality as RenderingServer.ViewportOcclusionCullingBuildQuality)
