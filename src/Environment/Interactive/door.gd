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
	anim.play("Open")

func _on_mouse_entered():
	tooltip.set_tooltip_text(tooltip_text)
	mouse_in_area = true

func _on_mouse_exited():
	tooltip.set_tooltip_text("")
	mouse_in_area = false

func _process(delta):
	if Input.is_action_just_pressed("left_click") and mouse_in_area:
		area_clicked = true

	if area_clicked and player_in_area and can_close:
		anim.play("Close")
		sfx_shut.play()
		door_open = false
		area_clicked = false
		
	if not door_open:
		tooltip_text = "closed"
		can_close = false
	
	elif door_open:
		can_close = true
		tooltip_text = "close"

func _on_body_entered(body):
	if body.name == "Player":
		player_in_area = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false

func _on_timer_timeout():
	anim.play("Open")
	sfx_creak.play()
	door_open = true
	
