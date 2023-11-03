extends Area2D

var tooltip_text = "close"
@onready var tooltip = get_node("/root/World/Post-Process/CursorTooltip")
@onready var anim = get_node("CollisionShape2D/AnimatedSprite2D") 
@onready var sfx_slide = get_node("AudioStreamPlayer2D")
@onready var can_close = true

var mouse_in_area = false
var player_in_area = false
var area_clicked = false
var window_open = true

func _ready():
	open_window("First")
	
func change_tooltip():
	if mouse_in_area:
		tooltip.set_tooltip_text(tooltip_text)
		
func _on_mouse_entered():
	tooltip.set_tooltip_text(tooltip_text)
	mouse_in_area = true

func _on_mouse_exited():
	tooltip.set_tooltip_text("")
	mouse_in_area = false

func _process(delta):
	change_tooltip()
	
	if Input.is_action_just_pressed("left_click") and mouse_in_area:
		area_clicked = true
#
#	for child in get_children():
#		if child.name == "TimerW1":
#			print("Window1:", $TimerW1.time_left)
#		if child.name == "TimerW2":
#			print("Window2:", $TimerW2.time_left)
#		if child.name == "TimerW3":
#			print("Window3:", $TimerW3.time_left)
#
	if area_clicked and player_in_area and can_close:
		close_window()
		
func _on_body_entered(body):
	if body.name == "Player":
		player_in_area = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false
	
func _on_TimerW1_timeout():
	open_window("_")
	
func _on_TimerW2_timeout():
	open_window("_")

func _on_TimerW3_timeout():
	open_window("_")

func open_window(state):
	tooltip_text = "close"
	anim.play("Open")
	if state != "First":
		sfx_slide.play()
	window_open = true
	can_close = true
	
func close_window():
	tooltip_text = "closed"
	sfx_slide.play()
	anim.play("Close")
	window_open = false
	area_clicked = false
	can_close = false
	
	for child in get_children():
		if child.name == "TimerW1":
			child.start()
		if child.name == "TimerW2":
			child.start()
		if child.name == "TimerW3":
			child.start()
	
	
