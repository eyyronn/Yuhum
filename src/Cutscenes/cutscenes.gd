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
	for child in get_children():
		if child.name.ends_with("CS"):
			child.set_volume_db(-9999.9999)
			if child.name == "IntroCS":
				emit_signal("intro_done")
				child.stop
				$".".hide()
				
			if child.name == "Task1CS":
				emit_signal("task1_done")
				child.stop
				$".".hide()
				
	$"../Post-Process".show()
	
func _on_intro_finished():
	for child in get_children():
		if child.name == "IntroCS":
			child.set_volume_db(-9999.9999)
			emit_signal("intro_done")
			child.stop
			$".".hide()
	

func _on_task_1cs_finished():
	for child in get_children():
		if child.name == "Task1CS":
			child.set_volume_db(-9999.9999)
			emit_signal("task1_done")
			child.stop
			$".".hide()
	

