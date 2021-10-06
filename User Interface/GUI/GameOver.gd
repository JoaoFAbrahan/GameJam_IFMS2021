extends CanvasLayer


func _on_Reiniciar_pressed():
	get_tree().reload_current_scene()
	get_node("GameOver_Controller").hide()

# Volta ao menu principal
func _on_MenuPrincipal_pressed():
	get_tree().change_scene("res://User Interface/Menu/Menu.tscn")


func _on_Main_Player__onPlayerDead(condition):
	print("teste")
