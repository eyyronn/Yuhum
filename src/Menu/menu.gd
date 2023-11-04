extends Node2D

@onready var mouse_in_area = false

func _physics_process(delta):
	pass
	
func _on_area_2d_mouse_entered():
	mouse_in_area = true
	get_node('Area2D/CollisionShape2D/AnimationPlayer').play("Pop")

func _on_area_2d_mouse_exited():
	mouse_in_area = false
	get_node('Area2D/CollisionShape2D/AnimationPlayer').play("Retract")
		
func _on_area_2d_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("left_click"):
		get_tree().change_scene_to_file("res://src/room.tscn")
		

func _on_area_2d_2_mouse_entered():
	mouse_in_area = true
	get_node('Area2D2/CollisionShape2D/AnimationPlayer2').play("Pop")
	
func _on_area_2d_2_mouse_exited():
	mouse_in_area = false
	get_node('Area2D2/CollisionShape2D/AnimationPlayer2').play("Retract")
	
func _on_area_2d_2_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("left_click"):
		get_tree().quit()
