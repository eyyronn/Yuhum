extends Node2D

func _ready():
	pass
#	print_tree_pretty()
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

@onready var is_paused = $Paused_
@onready var is_hear = $Player/AudioListener2D
@onready var bg_music = $"Static/BG Music"
@onready var tv_static = $Interactive/TV/AudioStreamPlayer2D
		
var paused = false

@warning_ignore("unused_parameter")
func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pause()

	
func pause():
	if paused:
		is_paused.hide()
		is_hear.make_current()
		tv_static.play()
		bg_music.play()
		Engine.time_scale = 1
	else:
		is_paused.show()
		is_hear.clear_current()
		tv_static.stop()
		bg_music.stop()
		Engine.time_scale = 0
	
	paused = !paused
	
	
