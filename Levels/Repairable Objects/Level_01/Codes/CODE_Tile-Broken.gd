extends StaticBody2D

#### Variables
onready var PlayerRef;
var isPlayerInside: bool;
var isReparable: bool;

func _ready():
	isPlayerInside = false;
	isReparable = true;
	$"Sprite-Normal".visible = false;

func _input(event):
	if event.is_action_pressed("PlayerAction_INTERACTION") && isPlayerInside && isReparable:
		## Controle da StateMachine
		PlayerRef.InteractAction("Tile");
		
		## Controle do objeto
		isReparable = false;
		$Icon.visible = false;
		
		## Troca sprite quebrado pelo normal
		$"Sprite-Broken".visible = false;
		$"Sprite-Normal".visible = true;
		
		## Adicionando pontuação
		PlayerRef._AddScore(150);

func _on_Repair_Area_body_entered(body):
	PlayerRef = body;
	if body.get_name() == "Main_Player":
		isPlayerInside = true;

func _on_Repair_Area_body_exited(body):
	if body.get_name() == "Main_Player":
		isPlayerInside = false;
