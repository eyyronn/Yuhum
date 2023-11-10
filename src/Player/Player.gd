extends CharacterBody2D

var click_position = Vector2.AXIS_X
var speed = Global.SPEED

@onready var anim = get_node("CollisionShape2D/Player")
@onready var sfx_run = get_node("Run")
@onready var can_move = 0
@onready var interactive = get_node("../Interactive")
@onready var play_close = false
@onready var can_close = false
@onready var can_sit = false
@onready var can_read = false

func _ready():
	click_position = Vector2(position.x, 0)
	anim.play("Idle")
	for child in interactive.get_children():
		child.mouse_entered.connect(_on_mouse_entered.bind(child))
		child.mouse_exited.connect(_on_mouse_exited.bind(child))
		if child.name.begins_with("Window"):
			child.window_is_closed.connect(_on_window_is_closed.bind(child))
			child.window_is_open.connect(_on_window_is_open.bind(child))
		if child.name == "Couch":
			child.sit_player.connect(_on_sit_player.bind(child))
			
func _process(delta):
	move_player(delta)
	
func move_player(delta):
	if Input.is_action_just_pressed("left_click") and can_move:
		click_position = get_global_mouse_position()
		sfx_run.play()

	var direction = (click_position - position).normalized()
	velocity.x = direction.x * speed
		
	if abs(position.x - click_position.x) < 0.1:
		if can_close:
			anim.play("Close")
		elif can_sit:
			position.y = 585
			anim.play("Sit")
		elif can_read:
			position.y = 610
			anim.play("Read")
			$"../Interactive/Bookshelf/Book".show()
		else:
			anim.play("Idle")
			position.y = Global.FLOOR
			sfx_run.stop()
			$"../Interactive/Bookshelf/Book".hide()

	elif position.x != click_position.x:
		position.y = Global.FLOOR + 5
		position = position.move_toward(Vector2(click_position.x, Global.FLOOR), delta * speed)
		anim.play("Run")
		$"../Interactive/Bookshelf/Book".hide()
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
	can_close = true
	
func _on_window_is_open(node):
	pass

func _on_sit_player(node):
	can_sit = true

func _on_player_animation_finished():
	if anim.get_animation() == "Close":
		anim.play("Idle")
		can_close = false
		
func _on_couch_body_exited(body):
	if body == self:
		can_sit = false

func _on_bookshelf_read_player():
	can_read = true

func _on_bookshelf_body_exited(body):
	if body == self:
		can_read = false
		

