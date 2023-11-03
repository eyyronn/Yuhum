extends Area2D

var tooltip_text = "close"
@onready var tooltip = get_node("/root/World/CursorTooltip")
@onready var anim = get_node("CollisionShape2D/AnimatedSprite2D")
@onready var can_close = true
@onready var sfx_creak = get_node("Creak")
@onready var sfx_shut = get_node("Shut")

var mouse_in_area = false
var player_in_area = false
var area_clicked = false
var door_open = true


func _ready():
	open_door("First")

func _on_mouse_entered():
	tooltip.set_tooltip_text(tooltip_text)
	mouse_in_area = true

func _on_mouse_exited():
	tooltip.set_tooltip_text("")
	mouse_in_area = false

func _process(delta):
	if Input.is_action_just_pressed("left_click") and mouse_in_area:
		area_clicked = true
		
	print($TimerDoor.time_left)
	
	if area_clicked and player_in_area and can_close:
		close_door()

func _on_body_entered(body):
	if body.name == "Player":
		player_in_area = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false

func _on_TimerDoor_timeout():
	open_door("_")
	
func open_door(state):
	anim.play("Open")
	if state != "First":
		sfx_creak.play()
	door_open = true
	can_close = true
	tooltip_text = "close"
	
func close_door():
	sfx_shut.play()
	anim.play("Close")
	door_open = false
	area_clicked = false
	tooltip_text = "closed"
	can_close = false
	$TimerDoor.start()
