extends Node

onready var player = $Main_Player;
var Minigame = load("res://Minigames/Minigame_1.tscn");

func _ready():
	var minigame = Minigame.instance();
	add_child(minigame);
	
	minigame.position = Vector2(player.position.x, player.position.y + 2);
