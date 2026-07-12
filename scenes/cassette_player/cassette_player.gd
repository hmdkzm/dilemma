# cassette_player.gd
extends Control

@onready var play_btn = $Play
@onready var back_btn = $Back
@onready var forward_btn = $Forward
@onready var stop_btn = $Stop
@onready var fast_forward_sfx = $FastForward
@onready var button_sfx = $ButtonPress
@onready var anim = $ReelAnimation
var is_forwarding = false
var is_rewinding = false
var is_cassette_at_start = true
var is_cassette_at_end = false

func _ready():
	# Connect toggle signals
	play_btn.toggled.connect(_on_play_pressed)
	forward_btn.toggled.connect(_on_forward_pressed)
	back_btn.toggled.connect(_on_back_pressed)
	fast_forward_sfx.finished.connect(_on_fast_forward_sfx_finnished)
	MusicManager.cassette_reseted.connect(_on_cassette_reseted)
	MusicManager.cassette_ended.connect(_on_cassette_ended)
	
	# Connect stop button to clear all states
	stop_btn.pressed.connect(_on_stop_pressed)
func _on_play_pressed(active: bool):
	button_sfx.play()
	if not is_cassette_at_end:
		if active:
			anim.play("playing")
			is_cassette_at_start = false
		fast_forward_sfx.stop()
		MusicManager.play(active)
	else:
		stop_cassette()
func _on_forward_pressed(active: bool) -> void:
	button_sfx.play()
	if not is_cassette_at_end:
		if active:
			anim.play("forwarding")
			is_cassette_at_start = false
		is_forwarding = active
		play_forward_rewind_sfx()
		MusicManager.fast_forward(active)
	else:
		stop_cassette()
func _on_back_pressed(active: bool) -> void:
	button_sfx.play()
	if not is_cassette_at_start:
		if active:
			is_rewinding = active
			is_cassette_at_end = false
			anim.play("rewinding")
			play_forward_rewind_sfx()
			MusicManager.rewind(active)
	else:
		stop_cassette()
func _on_stop_pressed():
	stop_cassette()
func stop_cassette():
	button_sfx.play()
	anim.stop()
	fast_forward_sfx.stop()
	# Clear the ButtonGroup so no button is toggled on
	# This assumes your buttons share the same group
	MusicManager.stop_all()
	var pressed_button = play_btn.button_group.get_pressed_button()
	if pressed_button:
		play_btn.button_group.get_pressed_button().button_pressed = false
func play_forward_rewind_sfx() -> void:
	if (is_forwarding or is_rewinding):
		fast_forward_sfx.play()
func _on_fast_forward_sfx_finnished() -> void:
	if (is_forwarding or is_rewinding):
		fast_forward_sfx.play()
func _on_cassette_reseted() -> void:
	is_cassette_at_start = true
	stop_cassette()
func _on_cassette_ended() -> void:
	is_cassette_at_end = true
	stop_cassette()
