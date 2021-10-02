extends Label

var Seconds;
var Minutes;

func _on_Main_Player_onChangeTime(time):
	## Calcula o valor do tempo
	Seconds = int(fmod(time, 60));
	Minutes = int(fmod(time,60*60) /60);
	
	text = String(Minutes) + ":" + String(Seconds);
