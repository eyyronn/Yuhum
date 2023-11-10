extends Node2D
signal intro_done
signal task1_done

@onready var play := false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	print_debug("Button")
	for child in get_children():
		if child.name.ends_with("CS"):
			if child.name == "IntroCS":
				child.set_volume_db(-9999.9999)
				emit_signal("intro_done")
				$".".hide()
				$"../Post-Process".show()
				child.set_paused(true)
				
			elif child.name == "Task1CS" and child.is_playing():
				child.set_volume_db(-9999.9999)
				emit_signal("task1_done")
				$".".hide()
				$"../Post-Process".show()
				child.set_paused(true)

func _on_intro_finished():
	print_debug("Intro")
	for child in get_children():
		if child.name == "IntroCS":
			child.set_volume_db(-9999.9999)
			emit_signal("intro_done")
			$".".hide()
			$"../Post-Process".show()
			if child.is_playing():
				child.set_paused(true)

func _on_task_1cs_finished():
	print_debug("Task 1")
	for child in get_children():
		if child.name == "Task1CS":
			child.set_volume_db(-9999.9999)
			emit_signal("task1_done")
			$".".hide()
			$"../Post-Process".show()
			if child.is_playing():
				child.set_paused(true)
				
	

