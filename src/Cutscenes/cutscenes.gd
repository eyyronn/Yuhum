extends Node2D


func _on_intro_finished():
	get_tree().change_scene_to_file("res://src/room.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://src/room.tscn")
