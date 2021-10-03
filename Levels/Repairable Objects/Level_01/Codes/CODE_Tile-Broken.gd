extends StaticBody2D

#### Variables
onready var PlayerRef;
var isPlayerInside: bool;

func _ready():
	isPlayerInside = false;

func _input(event):
	if event.is_action_pressed("PlayerAction_INTERACTION") && isPlayerInside:
		PlayerRef.InteractAction("Tile");

func _on_Repair_Area_body_entered(body):
	PlayerRef = body;
	if body.get_name() == "Main_Player":
		isPlayerInside = true;

func _on_Repair_Area_body_exited(body):
	if body.get_name() == "Main_Player":
		isPlayerInside = false;
