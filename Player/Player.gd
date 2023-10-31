extends CharacterBody2D

var speed = 400
var click_position = Vector2.AXIS_X
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Called when the node enters the scene tree for the first time.
func _ready():
	click_position = Vector2(position.x, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("left_click"):
		click_position = get_global_mouse_position()
		
	var direction = (click_position - position).normalized()
	velocity.x = (direction.x * speed)
	
	move_and_slide()
