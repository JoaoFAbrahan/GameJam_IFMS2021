extends CLASS_CharacterAttributes
class_name CLASS_Character
signal onChangeTime(time);
signal onCheckScore(_myScore, _levelScore);
signal onSpawnpoint();

##### Class Atributes
const UP_SIDE = Vector2(0, -1);
var VELOCITY = Vector2.ZERO;

#### Physics Atributes
var GRAVITY = 1000;
export (float,0,1.0) var FRICTION = 0.1;
export (float,0,1.0) var ACCELERATION = 0.25;

##### Classe Methodes
func _physics_process(delta: float) -> void:
	### Controle da Gravidade
	VELOCITY.y += GRAVITY * delta;
	
	### HUD
	## Controle do Tempo
	TimerCount(delta);
	PresentationScore();


#### Physics X axis Calculation
func CalculateVelocity(direction: float):
	### Verifica se o personagem esta parado ou andando
	if direction != 0:
		VELOCITY.x = lerp(VELOCITY.x, direction * Speed, ACCELERATION);
	else:
		VELOCITY.x = lerp(VELOCITY.x, 0, FRICTION);


#### Grounded Checker
func check_IsGrounded() -> bool:
	if is_on_floor():
		return true;
	else:
		return false;


#### HUD do Player
### Timer Count
func TimerCount(delta):
	MyTime -= delta
		
	if MyTime > 0:
		emit_signal("onChangeTime", MyTime);
		isAlive = true;
	else:
		isAlive = false;
		get_node("GameOver/GameOver").show();

### Score
func PresentationScore():
	emit_signal("onCheckScore", MyScore, Level_Score);
