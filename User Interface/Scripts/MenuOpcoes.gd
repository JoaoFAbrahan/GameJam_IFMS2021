extends Control

# acessar configurações
func _on_Configuraes_pressed():

# Voltar menu principal
func _on_MenuPrincipal_pressed():
	get_tree().change_scene("res://User Interface/Menu/Menu.tscn")

# sair do jogo
func _on_Sair_pressed():
	get_tree().quit()
