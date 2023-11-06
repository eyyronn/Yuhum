extends Node2D

func _ready():
	print_tree_pretty()
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

@onready var is_paused = $Paused_
		
var paused = false

@warning_ignore("unused_parameter")
func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pause()

	
func pause():
	if paused:
		is_paused.hide()
		Engine.time_scale = 1
	else:
		is_paused.show()
		Engine.time_scale = 0
	
	paused = !paused
	
	
