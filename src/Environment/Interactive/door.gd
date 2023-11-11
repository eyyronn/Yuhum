extends Area2D

@onready var tooltip = get_node("/root/World/Post-Process/CursorTooltip")
@onready var anim = get_node("CollisionShape2D/AnimatedSprite2D")
@onready var sfx_creak = get_node("Creak")
@onready var sfx_shut = get_node("Shut")

@export var tooltip_text := "close"
@export var can_close := true
@export var mouse_in_area := false
@export var player_in_area := false
@export var area_clicked := false
@export var door_open := true
@export var last_scene := false
var last_has_started := false

func _ready():
	open_door()
	
func change_tooltip():
	if mouse_in_area:
		tooltip.set_tooltip_text(tooltip_text)

func _on_mouse_entered():
	tooltip.set_tooltip_text(tooltip_text)
	mouse_in_area = true

func _on_mouse_exited():
	tooltip.set_tooltip_text("")
	mouse_in_area = false

@warning_ignore("unused_parameter")
func _process(delta):
	change_tooltip()
	
	if Input.is_action_just_pressed("left_click") and mouse_in_area:
		area_clicked = true
		
	if area_clicked and player_in_area and can_close:
		close_door()
	
	
	if last_scene:
		if not last_has_started:
			knock_door()
			last_has_started = true
		if area_clicked and player_in_area:
			$"../../Peephole".show()
			$"../../Post-Process".hide()
			
func _on_body_entered(body):
	if body.name == "Player":
		player_in_area = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false

func _on_timeout_closed():
	open_door()
	
func _on_timeout_open():
	print_debug("Game over")
	play_jumpscare()
	
func open_door():
	if not Global.init:
		print_debug("Ey")
		$TimerOpenDoor.set_wait_time(randf_range(30, 50))
		anim.play("Open")
		sfx_creak.play()
		door_open = true
		can_close = true
		tooltip_text = "close"
		$TimerOpenDoor.start()
	
func close_door():
	$TimerOpenDoor.stop()
	$TimerClosedDoor.set_wait_time(randf_range(30, 100))
	sfx_shut.play()
	anim.play("Close")
	door_open = false
	area_clicked = false
	tooltip_text = "closed"
	can_close = false
	$TimerClosedDoor.start()
	
func knock_door():
	$TimerOpenDoor.stop()
	$TimerClosedDoor.stop()
	$TimerKnock.set_wait_time(3.5)
#	sfx_shut.play()
#	anim.play("Close")
	door_open = false
	area_clicked = false
	tooltip_text = "peep"
	$TimerKnock.start()

func _on_tv_last_scene():
	anim.play("Close")
	last_scene = true

func _on_timer_knock_timeout():
	$Knock.play()
	
func play_jumpscare():
	$"../../Post-Process".hide()
	$"../../Cutscenes".hide()
	$"../../game_over1".show()
	
func _on_cutscenes_intro_done():
	Global.init = false

func _on_tv_last_available():
	$TimerOpenDoor.stop()
