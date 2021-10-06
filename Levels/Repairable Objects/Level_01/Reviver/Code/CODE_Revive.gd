extends StaticBody2D

#### Variables
onready var PlayerRef;
var isPlayerInside: bool;
var isRevived: bool;

#### EntryPoint
func _ready():
	isPlayerInside = false;
	isRevived = true;


#### Ação de interação
func _input(event):
	if event.is_action_pressed("PlayerAction_INTERACTION") && isPlayerInside && isRevived && PlayerRef.isGrounded:
		## Controle da StateMachine
		PlayerRef.InteractAction("Aliado");
		
		## Controle do objeto
		isRevived = false;
		$Icon.visible = false;
		
		## Troca sprite quebrado pelo normal
		$AnimationPlayer.play("Interaction");
		yield($AnimationPlayer,"animation_finished");
		$AnimationPlayer.play("Revived");
		
		## Adicionando pontuação
		PlayerRef._AddScore(200);


#### Verificador de area
func _on_Area2D_body_entered(body):
	PlayerRef = body;
	if body.get_name() == "Main_Player":
		isPlayerInside = true;
func _on_Area2D_body_exited(body):
	if body.get_name() == "Main_Player":
		isPlayerInside = false;
