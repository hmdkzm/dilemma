extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Inside your SFXManager.gd (Autoload)
func play_sfx(stream: AudioStream):
	var player = AudioStreamPlayer.new()
	add_child(player)
	player.bus = "FX"
	player.stream = stream
	player.play()
	# Clean up once done
	player.finished.connect(player.queue_free)
