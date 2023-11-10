extends Node2D


@onready var is_hear = $Player/AudioListener2D
@onready var bg_music = $"Static/BG Music"
@onready var tv_static = $"Interactive/TV/Static Noise"
		
var paused = false

@warning_ignore("unused_parameter")
func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pause()
		
func _ready():
	$"Post-Process".hide()
	$Cutscenes.show()
	$Cutscenes/IntroCS.play()
	$Cutscenes/IntroCS.set_volume_db(-5.0)
	

func _on_button_pressed():
	get_tree().change_scene_to_file("res://src/Menu/menu.tscn")
			
			
func pause():
	if paused:
#		is_paused.hide()
		is_hear.make_current()
		tv_static.play()
		bg_music.play()
		Engine.time_scale = 1
	else:
#		is_paused.show()
		is_hear.clear_current()
		tv_static.stop()
		bg_music.stop()
		Engine.time_scale = 0
		
	paused = !paused
	



