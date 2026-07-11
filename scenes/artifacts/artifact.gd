extends Area2D

@export var artifact_data: ArtifactData
@export var room_name: String
var artifact_key
func _ready():
	if artifact_data and artifact_data.icon:
		$Sprite2D.texture = artifact_data.icon
		var texture_size = artifact_data.icon.get_size()
		$CollisionShape2D.shape.size = texture_size
		$CollisionShape2D.position = Vector2.ZERO
	artifact_key = room_name + "_" + name
	if GameState.is_collected(artifact_key, artifact_data):
		queue_free()
		
func _on_body_entered(body):
	if body.name == "Player":
		GameState.mark_as_collected(artifact_key,artifact_data)
		InventoryManager.add_item(artifact_data)
		$CollisionShape2D.set_deferred("disabled", true)
		SfxManager.play_sfx(artifact_data.sfx)
		play_pickup_animation()
		
func play_pickup_animation():
	var tween = create_tween()
	tween.tween_property(self, "position", position + Vector2(0, -20), 0.3).set_trans(Tween.TRANS_QUAD)
	tween.parallel().tween_property(self, "modulate:a", 0.0, 0.3)
	tween.parallel().tween_property(self, "scale", Vector2(1.5, 1.5), 0.3)
	await tween.finished
	queue_free()
