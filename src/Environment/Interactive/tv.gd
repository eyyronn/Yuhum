extends Area2D

var tooltip_text = "Watch"
@onready var tooltip = get_node("/root/World/CursorTooltip")

func _on_mouse_entered():
	tooltip.set_tooltip_text(tooltip_text)

func _on_mouse_exited():
	tooltip.set_tooltip_text("")
