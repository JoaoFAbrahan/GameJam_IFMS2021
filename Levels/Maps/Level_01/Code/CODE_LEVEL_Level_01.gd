extends Node
onready var player = $"World Components/Main_Player"
var soundController = true;

func _process(delta):
	if player.Life_Status() == false:
		$"World Components/Main_Player/Level_Soundtrack".stop();
		if soundController:
			$"World Components/Main_Player/GameOver_Soundtrack".play();
			soundController = false;
