extends Control

func _on_Button_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Levels/Maps/Level_01/LEVEL_Level_01.tscn")

func _on_Config_pressed():
	get_node("Sound").show()
	AudioServer.generate_bus_layout()
	 
func _on_Button3_pressed():
	get_tree().quit()


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_FullScreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
