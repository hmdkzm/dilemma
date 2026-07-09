class_name Player extends CharacterBody2D
const FOOTSTEP_SFX = "res://scenes/player/assets/audio/bbc_footsteps-_07064076.ogg"
@export var speed = 300 # How fast the player will move (pixels/sec).
@onready var nav_agent = $NavigationAgent2D
@onready var anim = $AnimatedSprite2D
@onready var idle_timer = $IdleTimer
@onready var walk_sound = $WalkSound
var is_spawned_at_marker = false
var screen_size # Size of the game window.
var click_position = Vector2()
var target_position = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	if not is_spawned_at_marker:
		position = Vector2(540, 1300)
	click_position = position
	idle_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("click"):
		click_position = get_global_mouse_position()
		nav_agent.target_position = get_global_mouse_position()
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.play()
		if !walk_sound.is_processing():
			walk_sound.play()
		$IdleTimer.stop()
	velocity = Vector2.ZERO # The player's movement vector.
	if nav_agent.is_navigation_finished():
		walk_sound.stop()
		if anim.animation != "smoking": # Change "bored" to your specific animation
			if idle_timer.is_stopped():
				anim.animation = "stand"
				idle_timer.start()
		return
		
	var next_path_position = nav_agent.get_next_path_position()
	var direction = global_position.direction_to(next_path_position)
	velocity = direction * speed
	$AnimatedSprite2D.rotation_degrees = rad_to_deg(velocity.angle()) + 90
	move_and_slide()
	return
	


func _on_idle_timer_timeout() -> void:
	$AnimatedSprite2D.animation = "smoking"
	$AnimatedSprite2D.play()
