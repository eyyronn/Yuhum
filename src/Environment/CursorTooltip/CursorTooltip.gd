extends Node2D

var label : Label

func _ready():
	label = get_node("Label")

func _process(_delta):
	self.global_position = get_global_mouse_position()

func set_tooltip_text(text: String):
	label.text = text

