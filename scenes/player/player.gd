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
var is_input_locked: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InventoryManager.got_item.connect(_on_got_item)
	screen_size = get_viewport_rect().size
	if not is_spawned_at_marker:
		position = Vector2(540, 1300)
	click_position = position
	idle_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	ThoughtBubble.update_position(global_position)
	if Input.is_action_pressed("click") and !is_input_locked:
		click_position = get_global_mouse_position()
		nav_agent.target_position = get_global_mouse_position()
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
	if !nav_agent.is_target_reached():
		self.rotation_degrees = rad_to_deg(velocity.angle()) + 90
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.play()
		move_and_slide()
	else:
		walk_sound.stop()
		anim.animation = "stand"
	return
	


func _on_idle_timer_timeout() -> void:
	# Define an array of potential idle messages
	var idle_messages = [
		"So boring...", 
		"Waiting is the hardest part.", 
		"Any ideas?", 
        "I need a task!"
	]
	
	# Pick a random message from the array
	var random_message = idle_messages.pick_random()
	
	# Show the chosen message[cite: 1]
	ThoughtBubble.show_bubble(random_message, global_position, 5)

	$AnimatedSprite2D.animation = "smoking"
	$AnimatedSprite2D.play()

func _on_got_item(item) ->void:
	if item.name == "player":
		ThoughtBubble.show_bubble("Atleast got something to listen", global_position, 5)
	if item.name == "note":
		# Define an array of potential note messages
		var note_messages = [
			"I wonder what are these instructions for.",
			"Another note... what does it say?",
			"Hope this makes sense.",
            "More reading, great."
		]
		
		# Pick a random message from the array
		var random_note_message
		if InventoryManager.inventory.filter(is_note).size() > 0:
			random_note_message = note_messages.pick_random()
		else: random_note_message = note_messages[0] + ' tada'

		# Show the chosen message[cite: 1]
		ThoughtBubble.show_bubble(random_note_message, global_position, 5)
func is_note(item) -> bool:
	return item.name == "note" 
