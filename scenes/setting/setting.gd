extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_volume(0.5, "Sound")
	set_volume(0.5, "Music")
	set_volume(0.5, "SFX")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
# SettingsLayer.gd (Attached to your CanvasLayer)
func toggle_settings():
	visible = !visible
	# Optional: Pause the game when settings are open
	get_tree().paused = visible

func set_volume(value: float, bus_name: StringName) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), db)

func _on_close_button_pressed() -> void:
	toggle_settings()

func _on_sound_slider_value_changed(value: float) -> void:
	set_volume(value, "Sound")

func _on_music_slider_value_changed(value: float) -> void:
	set_volume(value, "Music")

func _on_sfx_slider_value_changed(value: float) -> void:
	set_volume(value, "SFX")
