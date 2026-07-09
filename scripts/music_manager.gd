# MusicManager.gd (Autoload)
extends Node

var music_player: AudioStreamPlayer
var current_track_index: int = 0
var playlist: Array[AudioStream] = [
	preload("res://assets/music/08. Reverse Running.mp3"),
	preload("res://assets/music/09. Amok.mp3"),
	preload("res://assets/music/02. Default.mp3")
	]

func _ready():
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Music" # Routes to your Music Bus
	music_player.finished.connect(_on_track_finished)
	add_child(music_player)
	play_playlist()
	

func play_playlist():
	current_track_index = 0
	_play_current_track()

func _play_current_track():
	if playlist.size() > 0:
		music_player.stream = playlist[current_track_index]
		music_player.play()

# Connect the finished signal to loop or move to next song
func _on_track_finished():
	current_track_index = (current_track_index + 1) % playlist.size()
	_play_current_track()
