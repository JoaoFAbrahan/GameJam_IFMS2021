extends Control

func _on_MenuPrincipal_pressed():
	get_tree().change_scene("res://User Interface/Menu/Menu.tscn")
func _on_Sair_pressed():
	get_tree().quit()
