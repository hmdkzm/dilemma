extends Area2D
@export var next_room_code: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$BottomExitShape.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if next_room_code != "":
			var path = "res://scenes/map/rooms/room_" + next_room_code + "/room_" + next_room_code + ".tscn"
			if FileAccess.file_exists(path):
				SceneManager.load_room(path, "SpawnTop")
			else:
				# Log an error so you can see it in the Debugger tab
				push_error("Room not found: " + path)
