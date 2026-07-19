extends Node

var inventory: Array[ArtifactData] = []
# Called when the node enters the scene tree for the first time.
signal inventory_changed(inventory: Array[ArtifactData])
signal got_item(item: ArtifactData)
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func add_item(artifact_data: ArtifactData) -> void:
	inventory.push_front(artifact_data)
	got_item.emit(artifact_data)
	inventory_changed.emit(inventory)
