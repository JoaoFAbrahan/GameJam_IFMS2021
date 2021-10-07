extends Control

func _input(event):
	yield( get_tree().create_timer(8.0), "timeout" )

func _on_Button_pressed():
	get_tree().change_scene("res://User Interface/Menu/Menu.tscn")
