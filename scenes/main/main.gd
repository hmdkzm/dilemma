extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PlayerButton.hide()
	$Inventory.got_player.connect(_on_got_player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# Preload the effect scene so it's ready to use
var click_effect_scene = preload("res://scenes/main/click_effect.tscn")

func _input(_event):
	if Input.is_action_pressed("click"):
		# Create an instance of the effect
		var effect = click_effect_scene.instantiate()
		# Set its position to where the mouse was clicked
		effect.position = get_global_mouse_position()
		# Add it to the scene tree
		add_child(effect)
func _on_got_player() -> void:
	$PlayerButton.show()
