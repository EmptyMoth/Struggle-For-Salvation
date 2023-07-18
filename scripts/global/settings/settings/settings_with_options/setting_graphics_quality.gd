class_name SettingGraphicsQuality
extends BaseSettingWithOptions


func _init() -> void:
	_options = {
		"LOW" = 0,
		"MEDIUM" = 1,
		"HIGH" = 2,
	}
	super("graphics_quality", "HIGH", _options)


func _execute() -> void:
	pass
	#ProjectSettings.set_setting("rendering/camera/depth_of_field/depth_of_field_bokeh_shape", graphics_quality)
	#ProjectSettings.set_setting("rendering/camera/depth_of_field/depth_of_field_bokeh_quality", graphics_quality)
	#RenderingServer.viewport_set_occlusion_culling_build_quality(graphics_quality as RenderingServer.ViewportOcclusionCullingBuildQuality)
