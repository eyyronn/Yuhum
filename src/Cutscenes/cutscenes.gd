extends Node2D


func _on_intro_finished():
	get_tree().change_scene_to_file("res://src/room.tscn")
	
func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		get_tree().change_scene_to_file("res://src/room.tscn")
	
