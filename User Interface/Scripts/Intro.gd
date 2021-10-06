extends Node2D


func _input(event):
	yield( get_tree().create_timer(3.0), "timeout" )
	get_tree().change_scene("res://User Interface/Menu/Menu.tscn")
