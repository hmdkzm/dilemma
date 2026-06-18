extends AnimatedSprite2D

@onready var anime = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anime.play("ripple")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	queue_free()
