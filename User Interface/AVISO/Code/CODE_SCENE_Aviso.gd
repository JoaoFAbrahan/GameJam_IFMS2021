extends Control
var timeIn = true;

func _input(event):
	if timeIn:
		$Timer.start();
		yield($Timer,"timeout");
		timeIn = false;
	get_tree().change_scene("res://User Interface/Menu/Menu.tscn")
