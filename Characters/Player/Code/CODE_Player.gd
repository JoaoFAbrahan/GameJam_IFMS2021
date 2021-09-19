extends Class_Character

### Player variables
var MoveDirection = Vector2.ZERO;
var RunSpeed: int;

### Constructor
func _ready() -> void:
	bIsAlive = true;
	Health = 100;
	Stamina = 50;
	Speed = 200;
	RunSpeed = 100;
	JumpHeight = -200;


### Player Controller
func _physics_process(delta: float) -> void:
	MoveDirection = Movimentation();
	
	VELOCITY = move_and_slide(MoveDirection, UP_SIDE);

func Movimentation() -> Vector2:
	## Movimentation Right/Left
	if Input.is_action_pressed("PlayerMove_RIGTH"):
		$Sprite.flip_h = false;
		$AnimationPlayer.play("Player_Plataform-RUN");
		if Input.is_action_pressed("PlayerAction_RUN"):
			VELOCITY.x = Speed + RunSpeed;
		else:
			VELOCITY.x = Speed;
	elif Input.is_action_pressed("PlayerMove_LEFT"):
		$Sprite.flip_h = true;
		$AnimationPlayer.play("Player_Plataform-RUN");
		if Input.is_action_pressed("PlayerAction_RUN"):
			VELOCITY.x = -Speed - RunSpeed;
		else:
			VELOCITY.x = -Speed;
	else:
		$AnimationPlayer.play("Player_Plataform-IDLE");
		VELOCITY.x = 0;
	
	if is_on_floor():
		if Input.is_action_just_pressed("PlayerAction_JUMP"):
			VELOCITY.y = JumpHeight;
	
	return VELOCITY;


### Interaction with Extern
func SetDamage(damage: int) -> void:
	if bIsAlive:
		Health -= damage;
		if Health < 0:
			bIsAlive = false;
