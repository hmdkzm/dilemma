extends Node

var inventory: Array[ArtifactData] = []
# Called when the node enters the scene tree for the first time.
signal inventory_changed(inventory: Array[ArtifactData])
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func add_item(artifact_data) -> void:
	inventory.push_front(artifact_data)
	inventory_changed.emit(inventory)
