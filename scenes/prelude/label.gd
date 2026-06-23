extends Label

func _ready():
	var anim = get_parent().get_node("AnimationPlayer")
	visible_characters = 0
	var tween = create_tween()
	var duration = text.length() * 0.075	
	tween.tween_property(self, "visible_characters", text.length(), duration)
	await tween.finished
	anim.play("show_buttons")
	
