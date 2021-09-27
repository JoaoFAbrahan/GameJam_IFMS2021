extends CLASS_Character

#### Player variables
export var doubleJump = false;
var Cont_Jump = 0;

var StateMachine;
var PlayerState = State.IDLE;
var Cont_Attack = 3;


#### EntryPoint
func _ready():
	### Inicializando variáveis
	ForwardFacing = 1;
	JumpHeight *= -1;
	isAlive = true;
	isCrouch = false;
	isAttack = false;
	
	#StateMachine = $AnimationTree.get("parameters/playback");
	$"Crouch-Collision".disabled = true;
func _physics_process(delta):
	### Processando os cálculos
	PlayerMovimentation();
	VELOCITY = move_and_slide(VELOCITY, UP_SIDE);
	isGrounded = check_IsGrounded();


#### Player Controller
func PlayerMovimentation():
	### Direção
	Movimentation();
	
	##### /// DEBUG /// #####
	#DebugMessage();
	
	### Ações
	CrouchAction();
	DashAction();
	JumpAction();
	
	### Ataques
	AttackAction();
	
	### Animações
	PlayerAnimation();

### Movimentação Básica
func Movimentation():
	var Direction;
	
	## Desativa temporariamente a movimentação no eixo X durante as animações de transições do Crouch
	if PlayerState != State.CROUCH_IN && PlayerState != State.CROUCH_OUT && !isAttack:
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
		if !isCrouch && !isAttack:
			if PlayerState != State.CROUCH_OUT:
				PlayerState = State.WALK;
		else:
			if PlayerState != State.CROUCH_IN && !isAttack:
				PlayerState = State.CROUCH_WALK;
	else:
		# StateMachine
		if !isCrouch && !isAttack:
			if PlayerState != State.CROUCH_OUT:
				PlayerState = State.IDLE;
		else:
			if PlayerState != State.CROUCH_IN && !isAttack:
				PlayerState = State.CROUCH_IDLE;
	
	## Processa o cálculo de movimentação do eixo X
	CalculateVelocity(Direction, isCrouch);

### Ação de Agachar
func CrouchAction():
	## Ativa caso o jogador ative a ação
	if Input.is_action_just_pressed("PlayerAction_CROUCH"):
		# Animação de entrando no modo Crouch
			PlayerState = State.CROUCH_IN;
			CollisionController(!isCrouch);
			isCrouch = true;
	
	## Ativa caso o jogador desative a ação
	if Input.is_action_just_released("PlayerAction_CROUCH"):
		# Animação de saindo do modo Crouch
			PlayerState = State.CROUCH_OUT;
			CollisionController(!isCrouch);
			isCrouch = false;

### Ação Agachar
func DashAction():
	pass

### Ação de Pular
func JumpAction():
	## Verifica se o pulo duplos está ativo ou não
	if doubleJump:
		if Input.is_action_just_pressed("PlayerAction_JUMP") && Cont_Jump < 2 && !isCrouch:
			# Faz o cálculo da física do eixo Y
			VELOCITY.y = JumpHeight;
			Cont_Jump += 1;
			
			# StateMachine
			PlayerState = State.JUMP;
		elif isGrounded:
			Cont_Jump = 0;
	else:
		if Input.is_action_pressed("PlayerAction_JUMP") && isGrounded && !isCrouch:
			# Faz o cálculo da física do eixo Y
			VELOCITY.y = JumpHeight;
			
			# StateMachine
			PlayerState = State.JUMP;

### Ação de Ataque
func AttackAction():
	## Verifica se o jogador está atacando
	if Input.is_action_pressed("PlayerAction_ATTACK") && isGrounded && VELOCITY.x < 100:
		isAttack = true;
		
		# StateMachine
		PlayerState = State.ATTACK;


#### State Machine Controller
func PlayerAnimation():
	### Verifica se o jogador esta colidindo com um piso
	if isGrounded:
		match PlayerState:
			State.IDLE:
				$AnimationPlayer.play("Idle");
			State.WALK:
				$AnimationPlayer.play("Walk");
			State.CROUCH_IN:
				$AnimationPlayer.play("Crouch-IN");
				yield($AnimationPlayer,"animation_finished");
				PlayerState = State.CROUCH_IDLE;
			State.CROUCH_OUT:
				$AnimationPlayer.play("Crouch-OUT");
				yield($AnimationPlayer,"animation_finished");
				PlayerState = State.IDLE;
			State.CROUCH_IDLE:
				$AnimationPlayer.play("Crouch_Idle");
			State.DASH:
				$AnimationPlayer.play("Dash");
			State.JUMP:
					$AnimationPlayer.play("Jump-UP");
			State.DEAD:
				$AnimationPlayer.play("Dead");
			State.DAMAGED:
				$AnimationPlayer.play("Damaged");
			State.ATTACK:
				## Inicio da animação de ataque
				$AnimationPlayer.play("Attack");
				#yield($AnimationPlayer,"animation_finished");
				
				## retorna o estado para falso
				isAttack = false;
	else:
		## Verifica se o jogador esta caindo
		if VELOCITY.y > 200:
			$AnimationPlayer.play("Fall");



#### Auxiliary Methods
### Troca as Colliders
func CollisionController(status: bool):
	$"Standard-Collision".disabled = status;
	$"Crouch-Collision".disabled = !status;
### DEBUG
func DebugMessage():
	print("X = ",VELOCITY.x, "  -  ","Y = ",VELOCITY.y);
	print(Cont_Jump);
