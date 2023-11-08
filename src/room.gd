extends Node2D

func _ready():
	pass
#	print_tree_pretty()
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://src/Menu/menu.tscn")
