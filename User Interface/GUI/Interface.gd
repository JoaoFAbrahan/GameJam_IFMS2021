extends CanvasLayer

func _input(event):
	if event.is_action_pressed("PlayerMenu_ESC"):
		get_node("MenuPausa").show()
		get_tree().paused = true

func _on_Continuar_pressed():
	get_tree().paused = false
	get_node("MenuPausa").hide()

func _on_MenuPrincipal_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://User Interface/Menu/Menu.tscn")

func _on_Sair_pressed():
	get_tree().quit()
