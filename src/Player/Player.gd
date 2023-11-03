extends CharacterBody2D

var click_position = Vector2.AXIS_X
var speed = Global.SPEED
@onready var anim = get_node("CollisionShape2D/AnimatedSprite2D")
@onready var sfx_run = get_node("Run")
@onready var interactive = get_node("../Interactive")

func _ready():
	click_position = Vector2(position.x, 0)
	anim.play("Idle")
	
func _process(delta):
	if Input.is_action_just_pressed("left_click") and in_interactive():
		click_position = get_global_mouse_position()
		sfx_run.play()

	var direction = (click_position - position).normalized()
	velocity.x = direction.x * speed
		
	if position.x != click_position.x:
		position.y = Global.FLOOR + 5
		position = position.move_toward(Vector2(click_position.x, Global.FLOOR), delta * speed)
		anim.play("Run")
		
#		print(position.x, click_position.x)
		if $Timer.time_left <= 0:
			$Run.pitch_scale = randf_range(0.8, 1.2)
			sfx_run.play()
			$Timer.start(0.3)
		
	if abs(position.x - click_position.x) < 0.01:
		anim.play("Idle")
		position.y = Global.FLOOR
		sfx_run.stop()
		
	if round(direction.x) == -1:
		anim.flip_h = true
	elif round(direction.x) == 1:
		anim.flip_h = false	

func in_interactive():
	var mouse_position = get_global_mouse_position()
	for child in interactive.get_children():
		if child is Area2D:
			var collision_shape = child.get_node("CollisionShape2D")
			if collision_shape and collision_shape.shape:
				print(collision_shape)
				var global_rect = Rect2(child.global_position - collision_shape.shape.extents, collision_shape.shape.extents * 2)
				if global_rect.has_point(mouse_position):
					return true
	return false


