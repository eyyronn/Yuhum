extends Area2D

signal window_is_closed
signal window_is_open
signal jumpscare
signal jumpscare_done

const PLAYER = "Player"
const TIMER_CLOSED_PREFIX = "TimerClosed"
const TIMER_OPEN_PREFIX = "TimerOpen"
const TOOLTIP_CLOSE = "close"
const TOOLTIP_CLOSED = "closed"

var tooltip_text = TOOLTIP_CLOSE
@onready var tooltip = get_node("/root/World/Post-Process/CursorTooltip")
@onready var anim = get_node("CollisionShape2D/AnimatedSprite2D") 
@onready var sfx_slide = get_node("AudioStreamPlayer2D")
@onready var can_close = true
@onready var init = true
@onready var task1_is_running = false

var jumpscares_played = false
var mouse_in_area = false
var player_in_area = false
var area_clicked = false
var window_open = true

func _ready():
	for child in get_children():
		if child.name.begins_with(TIMER_CLOSED_PREFIX):
			child.timeout.connect(_on_timeout_closed.bind())
			
	for child in get_children():
		if child.name.begins_with(TIMER_OPEN_PREFIX):
			child.timeout.connect(_on_timeout_open.bind())
			
	open_window()

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

	if area_clicked and player_in_area and can_close:
		close_window()
		
	if jumpscares_played:
		get_tree().change_scene_to_file("res://src/game_over.tscn")

func _on_body_entered(body):
	if body.name == PLAYER:
		player_in_area = true

func _on_body_exited(body):
	if body.name == PLAYER:
		player_in_area = false

func _on_timeout_closed():
	open_window()

func _on_timeout_open():
	print("Game Over", )

func open_window():
	if not init:
		emit_signal('window_is_open')
		for child in get_children():
			if child.name.begins_with(TIMER_OPEN_PREFIX):
				child.set_wait_time(randf_range(15, 30))
		tooltip_text = TOOLTIP_CLOSE
		anim.play("Open")
		sfx_slide.play()
		print_debug(init)
		Global.closed_windows -= 1
		window_open = true
		can_close = true
		print_debug(Global.closed_windows)
		start_timer_open()

func close_window():
	emit_signal('window_is_closed')
	
	for child in get_children():
			if child.name.begins_with(TIMER_CLOSED_PREFIX):
				child.set_wait_time(randf_range(30, 100))
				
	for child in get_children():
		if child.name.begins_with(TIMER_OPEN_PREFIX):
			child.stop()
			
	tooltip_text = TOOLTIP_CLOSED
	sfx_slide.play()
	anim.play("Close")
	window_open = false
	area_clicked = false
	can_close = false
	Global.closed_windows += 1
	print_debug(Global.closed_windows)
	
	start_timer_closed()

func start_timer_closed():
	for child in get_children():
		if child.name.begins_with(TIMER_CLOSED_PREFIX):
			child.start()
			
func start_timer_open():
	for child in get_children():
		if child.name.begins_with(TIMER_OPEN_PREFIX):
			child.start()

func _on_cutscenes_intro_done():
	init = false
	
func _on_task1_done(node):
	task1_is_running = true
	
func _on_peephole_end_game():
	$"../../Peephole/TheEnd".set_wait_time(4)
	$"../../Peephole/TheEnd".start()

func _on_the_end_timeout():
	open_window()
	emit_signal("jumpscare")
	$"../../Static/JumpscareTimer".set_wait_time(1)
	$"../../Static/JumpscareTimer".start()
	

func _on_jumpscare_timer_timeout():
	$"../../Static/JumpscareSound".play()
	$"../../Scare".show()
	$"../../Static/MenuTimer".set_wait_time(2)
	$"../../Static/MenuTimer".start()

func _on_menu_timer_timeout():
	get_tree().change_scene_to_file("res://src/game_over.tscn")
