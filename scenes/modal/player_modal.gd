class_name Modal extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
# SettingsLayer.gd (Attached to your CanvasLayer)
func toggle_settings():
	visible = !visible
	# Optional: Pause the game when settings are open
	get_tree().paused = visible


func _on_close_button_pressed() -> void:
	toggle_settings()
