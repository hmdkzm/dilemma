extends Area2D
@onready var anim = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_body_entered(body):
	print("abyss")
	if body.name == "Player":
		# Disable player input so they can't move away during the animation
		body.is_input_locked = true
		body.walk_sound.stop()
		MusicManager.stop_all()
		$FallSound.play()
		# Create the Tween
		var tween = create_tween()
		tween.set_parallel(true) # Run animations at the same time
		
		# 1. Animate towards the center of the abyss
		var center_pos = global_position
		tween.tween_property(body, "global_position", center_pos, 3)
		
		# 2. Add a rotation effect (circular motion)
		tween.tween_property(body, "rotation_degrees", 720, 3)
		
		# 3. Shrink to disappear
		tween.tween_property(body, "scale", Vector2.ZERO, 3)
		
		# Wait for the animation to finish
		await tween.finished
		
		# 4. Handle what happens next (e.g., respawn or change scene)
		print("Player consumed by abyss")
		body.queue_free() # Or trigger a scene transition
		TransitionLayer.change_scene("res://scenes/splash/splash.tscn")
