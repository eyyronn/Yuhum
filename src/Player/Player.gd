extends CharacterBody2D

var click_position = Vector2.AXIS_X
var speed = Global.SPEED
@onready var anim = get_node("CollisionShape2D/AnimatedSprite2D")

func _ready():
	click_position = Vector2(position.x, 0)
	
func _process(delta):
	if Input.is_action_just_pressed("left_click"):
		click_position = get_global_mouse_position()
	

	var direction = (click_position - position).normalized()
	velocity.x = direction.x * speed
	
		
	if position.x != click_position.x:
		position = position.move_toward(Vector2(click_position.x, Global.FLOOR), delta * speed)
		anim.play("run")
		
	else:
		anim.play("stop")
	
	
	if round(direction.x) == -1:
		anim.flip_h = true
	elif round(direction.x) == 1:
		anim.flip_h = false
