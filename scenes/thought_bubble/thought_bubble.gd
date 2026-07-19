extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_bubble(text, position, timeout, ) -> void:
	if text: $Label.text = text
	if position: global_position = position + Vector2(10, -10)
	if timeout: $Timer.wait_time = timeout
	show()
	if $Timer.is_stopped(): $Timer.start()
func update_position(position) -> void:
	if position: global_position = position + Vector2(10, -10)	


func _on_timer_timeout() -> void:
	hide()
	$Label.text = ""
	global_position = position
