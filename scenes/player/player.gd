extends CharacterBody2D

@export var speed = 300 # How fast the player will move (pixels/sec).
@onready var nav_agent = $NavigationAgent2D
var screen_size # Size of the game window.
var click_position = Vector2()
var target_position = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	position = screen_size / 2
	click_position = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("click"):
		click_position = get_global_mouse_position()
		nav_agent.target_position = get_global_mouse_position()
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.play()
	velocity = Vector2.ZERO # The player's movement vector.
	if nav_agent.is_navigation_finished():
		$AnimatedSprite2D.animation = "stand"
		return
		
	var next_path_position = nav_agent.get_next_path_position()
	var direction = global_position.direction_to(next_path_position)
	velocity = direction * speed
	var angle_in_degree = rad_to_deg(velocity.angle()) + 90
	$AnimatedSprite2D.rotation_degrees = angle_in_degree
	move_and_slide()
	return
		
	if position.distance_to(click_position) > 10:
		target_position = (click_position - position).normalized()
		velocity = target_position * speed
		move_and_slide()
		#var angle_in_degree = rad_to_deg(velocity.angle()) + 90
		$AnimatedSprite2D.rotation_degrees = angle_in_degree
	else:
		$AnimatedSprite2D.animation = "stand"
	
