extends CLASS_ActorAttributes
class_name CLASS_Character

##### Class Atributes
const UP_SIDE = Vector2(0, -1);
var VELOCITY = Vector2.ZERO;

#### Physics Atributes
export var GRAVITY = 1000;
export (float,0,1.0) var FRICTION = 0.1;
export (float,0,1.0) var ACCELERATION = 0.25;


##### Classe Methodes
func _physics_process(delta: float) -> void:
	### Controle da Gravidade
	if !isFlying:
		VELOCITY.y += GRAVITY * delta;
	else:
		VELOCITY.y = 0;


#### Physics X axis Calculation
func CalculateVelocity(direction: float, bCrouch: bool) -> void:
	if bCrouch == false:
		### Verifica se o personagem esta parado ou andando
		if direction != 0:
			VELOCITY.x = lerp(VELOCITY.x, direction * Speed, ACCELERATION);
		else:
			VELOCITY.x = lerp(VELOCITY.x, 0, FRICTION);
	else:
		## Verifica se o personagem esta parado ou andando
		if direction != 0:
			VELOCITY.x = lerp(VELOCITY.x, direction * (Speed - CrouchSpeed), ACCELERATION);
		else:
			VELOCITY.x = lerp(VELOCITY.x, 0, FRICTION);


#### Grounded Checker
func check_IsGrounded() -> bool:
	if is_on_floor():
		return true;
	else:
		return false;
