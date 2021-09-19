extends KinematicBody2D
class_name Class_Character

### Class Atributes
# Character variables
var bIsAlive: bool;
var Health: int;
var Stamina: int;
var Speed: int;
var JumpHeight: int;

# Physics Atributes
const UP_SIDE = Vector2(0, -1);
const GRAVITY = 9;
var VELOCITY = Vector2.ZERO;


### Classe Methodes
func _physics_process(delta: float) -> void:
	VELOCITY.y += GRAVITY;

func Life_Status() -> bool:
	return bIsAlive;
