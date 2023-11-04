extends Node2D

func _ready():
	print_tree_pretty()


func _on_button_pressed():
	get_tree().change_scene_to_file("res://src/Menu/menu.tscn")
