extends Control

# Signal to tell the main inventory which item slot got clicked
signal slot_clicked(slot_node: Control)

@onready var icon = $Icon

var is_selected: bool = false
var meta_data: ArtifactData

func _ready() -> void:
	if meta_data:
		$Icon.texture = meta_data.icon

func _gui_input(event: InputEvent) -> void:
	# Detect left-click on this specific slot
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Accept the event so it doesn't pass down to underlying UI elements
		accept_event() 
		slot_clicked.emit(self)

# Functions for the parent manager to call directly
func set_selection_visual(active: bool) -> void:
	is_selected = active
