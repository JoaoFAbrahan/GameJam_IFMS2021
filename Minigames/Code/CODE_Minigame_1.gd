extends KinematicBody2D

var Indicador = 0;
var indicadorSpeed = 1;
var IndicadorDirection = 1;

var maxRight = 30
var maxLeft = -30


func _process(delta):
	### Movimenta objeto
	$Indicador.position.x = Indicador;
	
	MovimentarIndicador();


#### Confirmar
func _input(event):
	if Input.is_action_just_pressed("PlayerMinigame_Confirm"):
		print("teste");

func MovimentarIndicador():
	if Indicador == maxRight:
		IndicadorDirection = -1;
	elif Indicador == maxLeft:
		IndicadorDirection = 1;
	
	Indicador += indicadorSpeed * IndicadorDirection;
