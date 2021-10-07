extends Control
var timeIn = true;

func _process(delta):
	if timeIn:
		$Timer.start();
		yield($Timer,"timeout");
		timeIn = false;
