extends KinematicBody2D
class_name CLASS_ActorAttributes

##### Class Atributes
### Character variables
export var Health = 100;
export var Stamina = 50;
export var Speed = 250;
export var CrouchSpeed = 70;
export var JumpHeight = 450;

### Character status
export var isAlive: bool;
export var isCrouch: bool;
export var isFlying: bool;

### Internal variables
var ForwardFacing: int;
var isAttack: bool;
var isGrounded: bool;

### Character Animation
enum State {IDLE, WALK, CROUCH_IN, CROUCH_OUT, CROUCH_IDLE, DASH, JUMP, FALL, DEAD, DAMAGED, ATTACK};


### Damage Controller
func Life_Status() -> bool:
	return isAlive;

func TakeDamage(damage: float):
	if Life_Status() && Health > 0:
		Health -= damage;

func GiveDamage(damage: float):
	pass
