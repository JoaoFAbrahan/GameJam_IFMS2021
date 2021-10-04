extends KinematicBody2D

#### Internal Variable
var Cursor = Vector2.ZERO;
var Posicao;
var Indicator_Direction;
var Left;
var Right;
var Inverter = false;
var Cont = 0;

### Controller
var Speed = 1;
var RangeLimit = 53;


#### EntryPoint
func _ready():
	Posicao = 0;
	Indicator_Direction = 1;
	Left = RangeLimit * -1;
	Right = RangeLimit;
func _process(delta):
	### Movimentação
	MovimentarCursor();
	Cursor = move_and_slide(Cursor);
	
	print(Inverter)

#### Logic Game
func MovimentarCursor():
	### Verifica Direção
	if Cont == RangeLimit:
		Cont = 0;
		Inverter = !Inverter;
	
	### Calcula Movimentação
	if !Inverter:
		Cursor.x += Speed;
		Cont += 1;
	else:
		Cursor.x = -Speed
		Cont +=1;

### Interation Action
func _input(event):
	if Input.is_action_just_pressed("PlayerMinigame_Confirm"):
		pass
