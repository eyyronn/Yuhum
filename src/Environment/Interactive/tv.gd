extends Area2D

signal task_available
signal last_available
signal last_scene

var tooltip_text = "finish tasks"
@onready var tooltip = get_node("/root/World/Post-Process/CursorTooltip")
@onready var mouse_in_area = false
@onready var first_done = false
@onready var second_done = false
@onready var task1_has_played = false
@onready var task1_done = false
@onready var area_clicked = false
@onready var player_in_area = false
@onready var last_has_played = false
@onready var last_is_available = false

func _ready():
	pass

func _process(delta):
	change_tooltip()
	
	if not first_done:
		first()
	elif first_done and not second_done:
		second()
		
	if Input.is_action_just_pressed("left_click") and mouse_in_area:
		area_clicked = true

	if area_clicked and player_in_area and first_done:
		emit_signal("task_available", 1)
		task1_has_played = true
		if task1_has_played and last_is_available:
			emit_signal("last_available")
			last_has_played = true
		
func change_tooltip():
	if mouse_in_area:
		tooltip.set_tooltip_text(tooltip_text)

func _on_mouse_entered():
	tooltip.set_tooltip_text(tooltip_text)
	mouse_in_area = true

func _on_mouse_exited():
	tooltip.set_tooltip_text("")
	mouse_in_area = false
	
func first():
	if Global.closed_windows == 3:
		$Static.hide()
		$Ting.play()
		$Exclamation.show()
		tooltip_text = "watch"
		first_done = true

func second():
	if Global.located_items == 6:
		$Static.hide()
		$Ting.play()
		$Exclamation.show()
		tooltip_text = "watch"
		second_done = true
		last_is_available = true

func _on_body_entered(body):
	if body.name == "Player":
		player_in_area = true
		
func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false

func _on_task_available(number):
	if not task1_has_played:
		$"../../Post-Process".hide()
		$"../../Cutscenes".show()
		var task = get_node("../../Cutscenes/Task" + str(number) + "CS")
		task.play()
		task.set_volume_db(-5.0)
		
func _on_cutscenes_task_1_done():
	$Static.show()
	$Exclamation.hide()
	tooltip_text = "finish tasks"

func _on_last_available():
	if not last_has_played and task1_has_played:
		print_debug("Hey")
		$"../../Post-Process".hide()
		$"../../Cutscenes".show()
		$"../../Cutscenes/LastCS".play()
		$"../../Cutscenes/LastCS".set_volume_db(-5.0)

func _on_cutscenes_last_done():
	$Static.show()
	$Exclamation.hide()
	tooltip_text = "finish tasks"
	emit_signal("last_scene")
