extends Area2D

signal read_player

var tooltip_text = "read"
@onready var tooltip = get_node("/root/World/Post-Process/CursorTooltip")
@onready var anim = get_node("CollisionShape2D/AnimatedSprite2D")
@onready var can_read = true
@onready var task1_is_running = false

var mouse_in_area = false
var player_in_area = false
var area_clicked = false
var is_clicked = false

func _ready():
	$"../../Cutscenes".task1_done.connect(_on_task1_done.bind(self))
	
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
		
	if area_clicked and player_in_area and mouse_in_area:
		if task1_is_running:
			if not is_clicked:
				$"../../Static/Correct".play()
				Global.located_items += 1
				is_clicked = true
		emit_signal("read_player")

func _on_body_entered(body):
	if body.name == "Player":
		player_in_area = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = false
	
func _on_task1_done(node):
	print_debug("Task 1 Start")
	task1_is_running = true
	
