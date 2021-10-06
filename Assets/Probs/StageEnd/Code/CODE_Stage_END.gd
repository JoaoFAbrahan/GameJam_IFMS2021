extends Area2D

onready var player = get_parent().get_node("Main_Player");
#onready var changer = get_parent().get_node("Transition_In");
onready var changer = $Transition_In
export var path: String;
var ScoreAchieved: bool;

func _ready():
	ScoreAchieved = false;
	$Sprite.visible = false;

func _process(delta):
	print(player.MyScore)
	if player.MyScore >= player.Level_Score:
		$Sprite.visible = true;
		ScoreAchieved = true;

func _on_Stage_END_body_entered(body):
	if body.name == "Main_Player" && ScoreAchieved:
		changer.change_scene(path)
