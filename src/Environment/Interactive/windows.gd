extends Area2D

const PLAYER = "Player"
const TIMER_PREFIX = "Timer"
const TOOLTIP_CLOSE = "close"
const TOOLTIP_CLOSED = "closed"

var tooltip_text = TOOLTIP_CLOSE
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
	for child in get_children():
		if child.name.begins_with(TIMER_PREFIX):
			child.timeout.connect(_on_timeout.bind())

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

func _on_body_entered(body):
	if body.name == PLAYER:
		player_in_area = true

func _on_body_exited(body):
	if body.name == PLAYER:
		player_in_area = false

func _on_timeout():
	open_window("_")

func open_window(state):
	tooltip_text = TOOLTIP_CLOSE
	anim.play("Open")
	if state != "First":
		sfx_slide.play()
	window_open = true
	can_close = true

func close_window():
	tooltip_text = TOOLTIP_CLOSED
	sfx_slide.play()
	anim.play("Close")
	window_open = false
	area_clicked = false
	can_close = false
	start_timers()

func start_timers():
	for child in get_children():
		if child.name.begins_with(TIMER_PREFIX):
			child.start()
