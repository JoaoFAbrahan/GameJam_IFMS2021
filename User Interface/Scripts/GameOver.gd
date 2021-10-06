extends Control

# Reinicia a fase
func _on_Reiniciar_pressed():
	get_tree().reload_current_scene()
	get_node("GameOver").hide()

# Volta ao menu principal
func _on_MenuPrincipal_pressed():
	get_tree().change_scene("res://User Interface/Menu/Menu.tscn")
