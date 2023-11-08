extends Area2D

var tooltip_text = "complete your tasks"
@onready var tooltip = get_node("/root/World/Post-Process/CursorTooltip")
@onready var mouse_in_area = false
@onready var alarm_has_played = false

func _ready():
	pass

func _process(delta):
	change_tooltip()
	if not alarm_has_played:
		first()
		
func change_tooltip():
	if mouse_in_area:
		tooltip.set_tooltip_text(tooltip_text)

func _on_mouse_entered():
	tooltip.set_tooltip_text(tooltip_text)
	mouse_in_area = true

func _on_mouse_exited():
	tooltip.set_tooltip_text("")
	mouse_in_area = false
	
func first():
	if Global.closed_windows == 3:
		print_debug("TV")
		$Static.hide()
		$Ting.play()
		$Exclamation.show()
		tooltip_text = "watch"
		alarm_has_played = true
