extends Node2D
@onready var anime = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anime.play("vortex_rotate")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("entered")
	var note_count = InventoryManager.inventory.filter(is_note).size()
	if body.name == "Player":
		if note_count == 1:
			print("got all secrets")
		else:
			print("you're not ready yet:", note_count)
func is_note(item) -> bool:
	return item.name == "note" 
