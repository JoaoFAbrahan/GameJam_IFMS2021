extends KinematicBody2D
class_name CLASS_CharacterAttributes

##### Class Atributes
### Character Signals


### Character variables
export var MaxHealth = 100;
export var Stamina = 50;
export var Speed = 250;
export var CrouchSpeed = 70;
export var JumpHeight = 450;

### Character status
export var isAlive: bool;
export var isCrouch: bool;
export var isFlying: bool;

### Internal variables
var health = MaxHealth;
var ForwardFacing: int;
var isAttack: bool;
var isGrounded: bool;

### Character Animation
enum State {IDLE, WALK, CROUCH_IN, CROUCH_OUT, CROUCH_IDLE, DASH, JUMP, FALL, DEAD, HURT, ATTACK};
var CharacterState = State.IDLE;


### Damage Controller
func Life_Status() -> bool:
	return isAlive;

func Heal(heal: int):
	if health < MaxHealth:
		health += heal;

func Damage(damage: int):
	if Life_Status() && health > 0:
		health -= damage;
		CharacterState = State.HURT;
	else:
		isAlive = false;
