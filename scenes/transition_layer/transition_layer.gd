extends CanvasLayer

func change_scene(target_path: String):
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target_path)
	$AnimationPlayer.play("fade_out")
func start_transition():
	$AnimationPlayer.play("fade_in")
	return $AnimationPlayer.animation_finished
func end_transition():
	$AnimationPlayer.play("fade_out")
	return $AnimationPlayer.animation_finished
