extends Node2D

@onready var exit = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if exit:
		exit = false

func _on_button_pressed():
	exit = true
	$".".hide()
	$"../Post-Process".show()
#	GameStateService.on_scene_transitioning("res://src/room.tscn")
#	get_tree().change_scene_to_file("res://src/room.tscn")
