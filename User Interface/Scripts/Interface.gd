extends CanvasLayer

func _input(event):
	if event.is_action_pressed("PlayerMenu_ESC"):
		get_node("MenuOpcoes").show()
	
