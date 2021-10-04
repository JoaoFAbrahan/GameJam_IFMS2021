extends KinematicBody2D
class_name CLASS_CharacterAttributes

##### Class Atributes
### Character variables
export var Level_Time = 300;
export var Level_Score = 1000;
export var Respawn_POS = Vector2(0,0);

### Internal variables
var Speed = 250;
var JumpHeight = 450;
var MyTime;
var MyScore;
var ForwardFacing: int;

### Character status
var isAlive: bool;
var isInteract: bool;
var isGrounded: bool;


### Character Animation
enum State {IDLE = 0, WALK, JUMP, FALL, INTERACTION};
var CharacterState = State.IDLE;


### Damage Controller
func Life_Status() -> bool:
	return isAlive;
