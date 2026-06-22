extends Node2D
@export_file("*.tscn") var next_scene_path

func _ready():
	# Play the fade-in animation
	$AnimationPlayer.speed_scale = 0.5
	$AnimationPlayer.play("fade_in")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file(next_scene_path)
