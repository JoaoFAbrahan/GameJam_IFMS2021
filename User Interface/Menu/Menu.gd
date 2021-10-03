extends Control

func _on_Button_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Levels/Maps/Level_TESTE/LEVEL_Level-Teste.tscn")

func _on_Button3_pressed():
	get_tree().quit()
