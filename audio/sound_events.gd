class_name SoundEvents
extends Node


enum {
	MOUSE_CLICK,
	RESET_SETTINGS,
	DROPDOWN_BUTTON_ON,
	DROPDOWN_BUTTON_OFF,
	CHECK_BUTTON_ON,
	CHECK_BUTTON_OFF,
	SCROLL_BUTTON,
	SETTINGS_TAB_BUTTON,
	BASE_BUTTON,
}

enum UISoundID {
	MOUSE_CLICK = SoundEvents.MOUSE_CLICK,
	RESET_SETTINGS = SoundEvents.RESET_SETTINGS,
	DROPDOWN_BUTTON_ON = SoundEvents.DROPDOWN_BUTTON_ON,
	DROPDOWN_BUTTON_OFF = SoundEvents.DROPDOWN_BUTTON_OFF,
	CHECK_BUTTON_ON = SoundEvents.CHECK_BUTTON_ON,
	CHECK_BUTTON_OFF = SoundEvents.CHECK_BUTTON_OFF,
	SCROLL_BUTTON = SoundEvents.SCROLL_BUTTON,
	SETTINGS_TAB_BUTTON = SoundEvents.SETTINGS_TAB_BUTTON,
	BASE_BUTTON = SoundEvents.BASE_BUTTON,
}


#static func _static_init() -> void:
	#FmodServer.load_bank("res://audio/banks/Master.strings.bank", FmodServer.FMOD_STUDIO_LOAD_BANK_NORMAL)
	#FmodServer.load_bank("res://audio/banks/Master.bank", FmodServer.FMOD_STUDIO_LOAD_BANK_NORMAL)
	#FmodServer.load_bank("res://audio/banks/2d.bank", FmodServer.FMOD_STUDIO_LOAD_BANK_NORMAL)
	#FmodServer.load_bank("res://audio/banks/3d.bank", FmodServer.FMOD_STUDIO_LOAD_BANK_NORMAL)
#
#
#static func create_event(event_id: int) -> FmodEvent:
	#return FmodServer.create_event_instance(get_audio_event_path(event_id))
#
##ЗВУКОВЫЕ ИВЕНТЫ
#static func get_audio_event_path(event_id: int) -> String:
	#match event_id:
		#SoundEvents.MOUSE_CLICK: return "event:/2d/Hit" #Это клик мыши
		#SoundEvents.RESET_SETTINGS: return "event:/2d/New Event 2"
		#SoundEvents.DROPDOWN_BUTTON_ON: return "event:/2d/New Event 2"
		#SoundEvents.DROPDOWN_BUTTON_OFF: return "event:/3d/Sword_hit"
		#SoundEvents.CHECK_BUTTON_ON: return "event:/2d/New Event 2"
		#SoundEvents.CHECK_BUTTON_OFF: return "event:/3d/Sword_hit"
		#SoundEvents.SCROLL_BUTTON: return "event:/2d/New Event 2"
		#SoundEvents.SETTINGS_TAB_BUTTON: return "event:/2d/New Event 2"
		#SoundEvents.BASE_BUTTON: return "event:/2d/New Event 2"
		#_: return ""


static func _static_init() -> void:
	FmodServer.load_bank("res://audio/banks/Desktop/Master.strings.bank", FmodServer.FMOD_STUDIO_LOAD_BANK_NORMAL)
	FmodServer.load_bank("res://audio/banks/Desktop/Master.bank", FmodServer.FMOD_STUDIO_LOAD_BANK_NORMAL)
	FmodServer.load_bank("res://audio/banks/Desktop/2d.bank", FmodServer.FMOD_STUDIO_LOAD_BANK_NORMAL)
	FmodServer.load_bank("res://audio/banks/Desktop/3d.bank", FmodServer.FMOD_STUDIO_LOAD_BANK_NORMAL)
	FmodServer.load_bank("res://audio/banks/Desktop/UI.bank", FmodServer.FMOD_STUDIO_LOAD_BANK_NORMAL)

static func create_event(event_id: int) -> FmodEvent:
	return FmodServer.create_event_instance(get_audio_event_path(event_id))

#ЗВУКОВЫЕ ИВЕНТЫ
static func get_audio_event_path(event_id: int) -> String:
	match event_id:
		SoundEvents.MOUSE_CLICK: return "event:/UI/MOUSE_CLICK" #Это клик мыши.
		SoundEvents.RESET_SETTINGS: return "event:/UI/RESET_SETTINGS"
		SoundEvents.DROPDOWN_BUTTON_ON: return "event:/UI/DROPDOWN_BUTTON_ON"
		SoundEvents.DROPDOWN_BUTTON_OFF: return "event:/UI/DROPDOWN_BUTTON_OFF"
		SoundEvents.CHECK_BUTTON_ON: return "event:/UI/CHECK_BUTTON_ON"
		SoundEvents.CHECK_BUTTON_OFF: return "event:/UI/CHECK_BUTTON_OFF"
		SoundEvents.SCROLL_BUTTON: return "event:/UI/SCROLL_BUTTON"
		SoundEvents.SETTINGS_TAB_BUTTON: return "event:/UI/SETTINGS_TAB_BUTTON"
		SoundEvents.BASE_BUTTON: return "event:/UI/BASE_BUTTON"
		_: return ""
