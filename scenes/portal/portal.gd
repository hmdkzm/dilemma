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
		if note_count == 8:
			ThoughtBubble.show_bubble("Finally, Let's see what happens", global_position, 7)
		else:
			ThoughtBubble.show_bubble("It seems I need some Instructions", global_position, 7)
func is_note(item) -> bool:
	return item.name == "note" 
