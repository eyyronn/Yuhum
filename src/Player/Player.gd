extends CharacterBody2D

var click_position = Vector2.AXIS_X
var speed = Global.SPEED

@onready var anim = get_node("CollisionShape2D/AnimatedSprite2D")
@onready var sfx_run = get_node("Run")
@onready var can_move = 0
@onready var interactive = get_node("../Interactive")
@onready var play_close = false
@onready var can_close = 0

func _ready():
	click_position = Vector2(position.x, 0)
	anim.play("Idle")
	for child in interactive.get_children():
		child.mouse_entered.connect(_on_mouse_entered.bind(child))
		child.mouse_exited.connect(_on_mouse_exited.bind(child))
		if child.name.begins_with("Window"):
			child.window_is_closed.connect(_on_window_is_closed.bind(child))
			child.window_is_open.connect(_on_window_is_open.bind(child))


func _process(delta):
	if Input.is_action_just_pressed("left_click") and can_move:
		click_position = get_global_mouse_position()
		sfx_run.play()

	var direction = (click_position - position).normalized()
	velocity.x = direction.x * speed
		
	if abs(position.x - click_position.x) < 0.1:
		if can_close:
			anim.stop()
			anim.play("Close")
			can_close -= 1
		else:
			anim.play("Idle")
			position.y = Global.FLOOR
			sfx_run.stop()

	elif position.x != click_position.x:
		position.y = Global.FLOOR + 5
		position = position.move_toward(Vector2(click_position.x, Global.FLOOR), delta * speed)
		anim.play("Run")
		
#		print(position.x, click_position.x)
		if $Timer.time_left <= 0:
			$Run.pitch_scale = randf_range(0.8, 1.2)
			sfx_run.play()
			$Timer.start(0.3)
		
	face_direction(direction.x)
	
func face_direction(direction):
	if  direction < 0: anim.flip_h = true
	elif direction > 0: anim.flip_h = false	
	
func _on_mouse_entered(node):
	can_move += 1

func _on_mouse_exited(node):
	can_move -= 1

func _on_window_is_closed(node):
	can_close = 10
	
func _on_window_is_open(node):
	pass
