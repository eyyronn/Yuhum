extends Area2D

var tooltip_text = "walk"
@onready var tooltip = get_node("/root/World/Post-Process/CursorTooltip")
@onready var mouse_in_area = false

func _ready():
	pass

func _process(delta):
	change_tooltip()
	
func change_tooltip():
	if mouse_in_area:
		tooltip.set_tooltip_text(tooltip_text)
		
func _on_mouse_entered():
	tooltip.set_tooltip_text(tooltip_text)
	mouse_in_area = true

func _on_mouse_exited():
	tooltip.set_tooltip_text("")
	mouse_in_area = false
