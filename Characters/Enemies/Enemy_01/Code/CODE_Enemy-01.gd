extends CLASS_Character

#### Enemy variables
var EnemyState;
var StateMachine;

#### EntryPoint
func _ready():
	### Inicializando variáveis
	health = 20
	HealthBar = get_node("HealthBar");
	HealthBar.MaxHealth_Update(health);
	ForwardFacing = 1;
	#health = 10;
	isAlive = true;
	isAttack = false;
func _process(delta):
	### Processando os cálculos
	Death();
	Movimentation();
	
	TerrainDetection();
	EnemyAnimation();
	VELOCITY = move_and_slide(VELOCITY, UP_SIDE);


func Movimentation():
	##### /// DEBUG /// #####
	#print("Enemy: ", health)
	
	if ForwardFacing != 0 && health > 0:
		VELOCITY.x = Speed * ForwardFacing;
	else:
		VELOCITY.x = 0;

#### IA
func TerrainDetection():
	if !$RayCast_DOWN.is_colliding() && is_on_floor() || $RayCast_Forward.is_colliding() && isAlive:
		scale.x = -scale.x;
		ForwardFacing *= -1;
		CharacterState = State.IDLE;
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Idle" && isAlive:
		CharacterState = State.WALK;
func Death():
	if !health > 0:
		CharacterState = State.DEAD;


#### State Machine Controller
func EnemyAnimation():
	match CharacterState:
		State.IDLE:
			$AnimationPlayer.play("Idle");
		State.WALK:
			$AnimationPlayer.play("Walk");
		State.HURT:
			$AnimationPlayer.play("Hurt");
			yield($AnimationPlayer,"animation_finished");
			CharacterState = State.WALK;
		State.DEAD:
			# Desativa colisão de dano
			$"Hit-COLLISION/CollisionShape2D".disabled = true;
			
			# Inicia animação de morte
			$AnimationPlayer.play("Death");
			yield($AnimationPlayer,"animation_finished");
			$AnimationPlayer.stop()
			
			# Remove o inimigo da cena
			queue_free();


#### Signal method
func _on_HitCOLLISION_body_entered(body):
	body.Damage(10);
	body.HealthBar.Health_Update(body.health, 10);
