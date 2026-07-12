# MusicManager.gd (Autoload)
extends Node

var music_player: AudioStreamPlayer
var current_track_index: int = 0
var playlist: Array[AudioStream] = [
	preload("res://assets/music/08. Reverse Running.mp3"),
	preload("res://assets/music/09. Amok.mp3"),
	preload("res://assets/music/02. Default.mp3")
	]
var is_fast_forwarding = false
var is_rewinding = false
var is_playing = false
var playback_position = 0
var music_length
const SCRUB_SPEED = 50 # Seconds per second
signal cassette_reseted()
signal cassette_ended()
func _ready():
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Music" # Routes to your Music Bus
	music_player.finished.connect(_on_track_finished)
	add_child(music_player)
	load_player()

func _process(delta):
	if is_playing:
		playback_position = music_player.get_playback_position()
	if is_fast_forwarding:
		print(playback_position)
		playback_position = (playback_position + (SCRUB_SPEED * delta))
		if playback_position >= music_length:
			if current_track_index < playlist.size() - 1:
				print("next", current_track_index)
				next_track()
			else:
				print("ended")
				cassette_ended.emit()
	elif is_rewinding:
		playback_position = playback_position - (SCRUB_SPEED * delta)
		if playback_position <= 0:
			if current_track_index > 0:
				previous_track()
			else:
				cassette_reseted.emit()
				current_track_index = 0
	

func load_player() -> void:
	if playlist.size() > 0:
		music_player.stream = playlist[current_track_index]
		music_length = music_player.stream.get_length()
		if is_rewinding:
			playback_position = music_length
		if is_fast_forwarding:
			playback_position = 0

# Connect the finished signal to loop or move to next song
func _on_track_finished():
	current_track_index = (current_track_index + 1) % playlist.size()
	load_player()
	play(true)
func play(active) -> void:
	is_playing = active
	if active:
		if playback_position > 0:
			music_player.play()
			music_player.seek(playback_position)
		else:
			music_player.play()	
func next_track() -> void:
	current_track_index = min((current_track_index + 1) ,playlist.size() - 1)
	load_player()
func previous_track() -> void:
	current_track_index = max(0, current_track_index - 1)
	load_player()
func fast_forward(active: bool):
	if active: music_player.stop()
	is_fast_forwarding = active
	music_player.pitch_scale = 3.0 if active else 1.0

func rewind(active: bool):
	if active: music_player.stop()
	is_rewinding = active
	music_player.pitch_scale = 1.0 # Keep standard pitch while jumping back

func stop_all():
	is_playing = false 
	is_fast_forwarding = false
	is_rewinding = false
	music_player.pitch_scale = 1.0
	music_player.stop()
