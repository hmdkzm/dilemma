extends Control
const SLOT_SCENE = preload("res://scenes/inventory/inventory_slot.tscn")
@onready var inv = $ScrollContainer/GridContainer
# Called when the node enters the scene tree for the first time.
var artifacts: Array[ArtifactData] = InventoryManager.inventory
func _ready() -> void:
	InventoryManager.inventory_changed.connect(_on_inventory_changed)
	render_inventory(artifacts)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func render_inventory(artifacts: Array[ArtifactData]) -> void:
	for child in inv.get_children():
		child.queue_free()
	for i in range(artifacts.size()):
		var new_slot = SLOT_SCENE.instantiate()
		new_slot.meta_data = artifacts[i]
		inv.add_child(new_slot)
func _on_inventory_changed(artifacts: Array[ArtifactData]) -> void:
	render_inventory(artifacts)
