extends Node2D
var intro = true

func _input(event):
	if intro:
		intro = false
		$Timer.start()
		$LogoTheme.play()
		yield($Timer, "timeout")
		get_tree().change_scene("res://User Interface/Menu/Menu.tscn")
