extends CLASS_Character

#### Player variables
export var DashDistance = 2000;
var onDash = false;


#### EntryPoint
func _ready():
	### Inicializando variáveis
	ForwardFacing = 1;
	JumpHeight *= -1;
	isAlive = true;
	isCrouch = false;
	isAttack = false;
	
	#StateMachine = $AnimationTree.get("parameters/playback");
	$"Dash-COLLISION".disabled = true;
#func _physics_process(delta):
#	### Processando os cálculos
#	PlayerMovimentation();
#	VELOCITY = move_and_slide(VELOCITY, UP_SIDE);
#	isGrounded = check_IsGrounded();

func _process(delta):
	### Processando os cálculos
	PlayerMovimentation();
	VELOCITY = move_and_slide(VELOCITY, UP_SIDE);
	isGrounded = check_IsGrounded();

#### Player Controller
func PlayerMovimentation():
	### Direção
	Movimentation();
	
	##### /// DEBUG /// #####
	DebugMessage();
	
	### Ações
	JumpAction();
	CrouchAction();
	DashAction();
	
	### Ataques
	AttackAction();
	
	### Animações
	PlayerAnimation();

### Movimentação Básica
func Movimentation():
	var Direction;
	
	if CharacterState != State.CROUCH_IN && CharacterState != State.CROUCH_OUT && !isAttack && !onDash && CharacterState != State.HURT:
		# Movimentação ESQUERDA/DIREITA
		Direction = Input.get_action_strength("PlayerMovement_RIGHT") - Input.get_action_strength("PlayerMovement_LEFT");
	else:
		Direction = 0;
	
	## Controla a direção da sprite
	if Direction != 0:
		# Define posição da sprite
		ForwardFacing = Direction;
		$Sprite.scale.x = Direction;
		
		# StateMachine
		if !isCrouch && !isAttack && !onDash && isGrounded && CharacterState != State.HURT:
			if CharacterState != State.CROUCH_OUT:
				CharacterState = State.WALK;
	else:
		# StateMachine
		if !isCrouch && !isAttack && !onDash && isGrounded && CharacterState != State.HURT:
			if CharacterState != State.CROUCH_OUT:
				CharacterState = State.IDLE;
		else:
			if CharacterState != State.CROUCH_IN && !isAttack && !onDash && CharacterState != State.HURT:
				CharacterState = State.CROUCH_IDLE;
	
	## Processa o cálculo de movimentação do eixo X
	CalculateVelocity(Direction, isCrouch);

### Ação de Agachar
func CrouchAction():
	if Input.is_action_just_pressed("PlayerAction_CROUCH") && CharacterState != State.CROUCH_IDLE:
		## Animação de entrando no modo Crouch
			CharacterState = State.CROUCH_IN;
			#CollisionController(!isCrouch);
			isCrouch = true;
	
	if Input.is_action_just_released("PlayerAction_CROUCH"):
		# Animação de saindo do modo Crouch
			CharacterState = State.CROUCH_OUT;
			#CollisionController(!isCrouch);
			isCrouch = false;

### Ação de Dash
func DashAction():
	var dashDirection;
	
	if Input.is_action_just_pressed("PlayerAction_DASH") && isGrounded:
		dashDirection = Vector2(ForwardFacing,0);
		VELOCITY = dashDirection.normalized() * DashDistance;
		
		CollisionController(true);
		onDash = true;
		CharacterState = State.DASH;

### Ação de Pular
func JumpAction():
	if Input.is_action_just_pressed("PlayerAction_JUMP") && isGrounded && !isCrouch && !onDash:
		# Calcula a física do pulo
		VELOCITY.y = JumpHeight;
		
		# StateMachine
		CharacterState = State.JUMP;

### Ação de Ataque
func AttackAction():
	## Verifica se o jogador está atacando
	if Input.is_action_pressed("PlayerAction_ATTACK") && isGrounded && VELOCITY.x < 100:
		isAttack = true;
		
		# StateMachine
		CharacterState = State.ATTACK;
### Signal method
func _on_Hit_Area_body_entered(body):
	#print(body.Life_Status())
	body.Damage(10);


#### State Machine Controller
func PlayerAnimation():
	### Verifica se o jogador esta colidindo com um piso
	if isGrounded:
		match CharacterState:
			State.IDLE:
				$AnimationPlayer.play("Idle");
			State.WALK:
				$AnimationPlayer.play("Walk");
			State.CROUCH_IN:
				$AnimationPlayer.play("Crouch-IN");
				yield($AnimationPlayer,"animation_finished");
				CharacterState = State.CROUCH_IDLE;
			State.CROUCH_OUT:
				$AnimationPlayer.play("Crouch-OUT");
				yield($AnimationPlayer,"animation_finished");
				CharacterState = State.IDLE;
			State.CROUCH_IDLE:
				$AnimationPlayer.play("Crouch-Idle");
			State.DASH:
				$AnimationPlayer.play("Dash");
				yield($AnimationPlayer,"animation_finished");
				CollisionController(false);
				onDash = false;
			State.JUMP:
					$AnimationPlayer.play("Jump");
					#yield($AnimationPlayer,"animation_finished");
			State.HURT:
				## Inicia a animação de receber dano
				$AnimationPlayer.play("Hurt");
				yield($AnimationPlayer,"animation_finished");
				
				## Retorna ao estado padrão
				CharacterState = State.IDLE;
			State.ATTACK:
				## Inicia a animação de ataque
				$AnimationPlayer.play("Attack");
				yield($AnimationPlayer,"animation_finished");
				
				## Retorna o estado para falso
				isAttack = false;
			State.DEAD:
				$AnimationPlayer.play("Dead");
	else:
		## Verifica se o jogador esta caindo
		if VELOCITY.y >= 200:
			onDash = false;
			isAttack = false;
			isCrouch = false;
			$AnimationPlayer.play("Fall");


#### Auxiliary Methods
### Troca as Colliders
func CollisionController(status: bool):
	$"Standard-COLLISION".disabled = status;
	$"Dash-COLLISION".disabled = !status;
### DEBUG
func DebugMessage():
	#print("X = ",VELOCITY.x, "  -  ","Y = ",VELOCITY.y);
	print("Player: ", health);







