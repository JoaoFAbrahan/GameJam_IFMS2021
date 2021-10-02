extends KinematicBody2D
class_name CLASS_CharacterAttributes

##### Class Atributes
### Character variables
export var Level_Time = 300;
export var Speed = 250;
export var JumpHeight = 450;

### Character status
export var isAlive: bool;

### Internal variables
var MyTime;
var ForwardFacing: int;
var isInteract: bool;
var isGrounded: bool;

### Character Animation
enum State {IDLE = 0, WALK, JUMP, FALL, GAMEOVER, MINIGAME_FAIL, INTERACTION};
var CharacterState = State.IDLE;


### Damage Controller
func Life_Status() -> bool:
	return isAlive;
