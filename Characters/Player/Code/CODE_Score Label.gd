extends Label

#### Passa as informações para a UI
func _on_Main_Player_onCheckScore(_myScore, _levelScore):
	text = "Score Needed: " + String(_levelScore);
	$"MyScore Label".text = "Your Score: " + String(_myScore);
