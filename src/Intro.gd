extends VideoStreamPlayer

@warning_ignore("unused_parameter")


func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pass
#		get_tree().change_scene_to_file("res://src/room.tscn")

func _on_button_pressed():
	$"..".hide()


func _on_task_1_finished():
	$"..".hide()
#	get_tree().change_scene_to_file("res://src/room.tscn")

func _on_finished():
	$"..".hide()
