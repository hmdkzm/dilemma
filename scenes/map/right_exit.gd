extends Area2D
@export_file("*.tscn") var next_level_path

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RightExitShape.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if next_level_path:
			SceneManager.load_room(next_level_path, "SpawnLeft")
