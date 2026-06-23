extends Node

var player_scene = preload("res://scenes/player/player.tscn")
var entry_point = "SpawnBottom"
var player: Player


func load_room(room_path: String, spawn_side: String):
	await TransitionLayer.start_transition()
	var room_container = get_tree().root.get_node("Main/RoomContainer")
	print("new room path:", room_path)
	player = get_tree().root.find_child("Player", true, false)
	entry_point = spawn_side
	for room in room_container.get_children():
		room.queue_free()
	player.get_parent().remove_child(player)
	var new_room_resource = load(room_path)
	if new_room_resource:
		var new_room = new_room_resource.instantiate()
		room_container.call_deferred("add_child", new_room)
	call_deferred("_position_player")

func _position_player():
	var room_container = get_tree().root.get_node("Main/RoomContainer")
	var anim = player.get_node("AnimatedSprite2D")
	var new_player = player_scene.instantiate()
	new_player.name = "Player"
	new_player.get_node("AnimatedSprite2D").rotation_degrees = anim.rotation_degrees
	new_player.is_spawned_at_marker = true
	var current_room = room_container.get_child(0)
	if new_player and current_room.has_node(entry_point):
		new_player.global_position = current_room.get_node(entry_point).global_position
		#new_player.get_node("NavigationAgent2D").target_position = player.global_position
		get_tree().root.add_child(new_player)
	TransitionLayer.end_transition()
