extends CLASS_Character

#### Player Variables
var MyScore;
var InteractTo;


#### EntryPoint
func _ready():
	### Inicializando variáveis
	ForwardFacing = 1;
	JumpHeight *= -1;
	isAlive = true;
	isInteract = false;
	
	MyTime = Level_Time;
	MyScore = 0;
func _process(delta):
	### Processando os cálculos
	PlayerMovimentation();
	if isAlive:
		
		VELOCITY = move_and_slide(VELOCITY, UP_SIDE);
		isGrounded = check_IsGrounded();
	else:
		CharacterState = State.GAMEOVER;
		print("GAMEOVER");
		if CharacterState == State.GAMEOVER:
			print("death");


#### Player Controller
func PlayerMovimentation():
	### Direção
	Movimentation();
	
	##### /// DEBUG /// #####
	#DebugMessage();
	
	### Ações
	JumpAction();
	
	## Animation
	PlayerAnimation();


### Direção eixo X
func Movimentation():
	var Direction;
	
	## Controle de Direção
	if !isInteract && isAlive:
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
		if !isInteract && isGrounded && isAlive:
			CharacterState = State.WALK;
	else:
		# StateMachine
		if !isInteract && isGrounded && isAlive:
			CharacterState = State.IDLE;
	
	## Processa o cálculo de movimentação do eixo X
	CalculateVelocity(Direction);

### Ação de Pular
func JumpAction():
	if Input.is_action_pressed("PlayerAction_JUMP") && isGrounded:
		# Calcula a física do pulo
		VELOCITY.y = JumpHeight;
		
		# Efeito Sonoro
		$SFX/Jump_SFX.play();
		
		# StateMachine
		CharacterState = State.JUMP;

### Ação de Interação
func _on_InteractionAREA_body_entered(body):
	## Verifica se o jogador está interagindo
	if Input.is_action_pressed("PlayerAction_INTERACTION") && isGrounded && VELOCITY.x < 100:
		# Passa o tipo de objeto o jogador está interagindo
		InteractTo = body.Type;
		
		# StateMachine
		isInteract = true;
		CharacterState = State.INTERACTION;


#### State Machine Controller
func PlayerAnimation():
	if isGrounded:
		match CharacterState:
			State.IDLE:
				$AnimationPlayer.play("Idle");
			State.WALK:
				$AnimationPlayer.play("Walk");
			State.JUMP:
				$AnimationPlayer.play("Jump");
				yield($AnimationPlayer,"animation_finished");
			State.INTERACTION:
				## Verifica com qual tipo de objeto o jogador está interagindo
				if InteractTo == "Plataforma":
					# Ativa animação de reparo de plataforma
					$AnimationPlayer.play("Interation_1");
				elif InteractTo == "Cano":
					# Ativa animação de desentupir cano 
					$AnimationPlayer.play("Interation_2");
				else:
					# Ativa animação de reviver aliado 
					$AnimationPlayer.play("Interation_3")
			State.MINIGAME_FAIL:
				$AnimationPlayer.play("Minigame_Fail");
			State.GAMEOVER:
				$AnimationPlayer.play("GameOver");
				yield($AnimationPlayer,"animation_finished");
	else:
		if VELOCITY.y >= 200:
			isInteract = false;
			$AnimationPlayer.play("Fall");


#### Signals Functions
### Adiciona mais tempo
func _AddTime(time: int):
	MyTime += time;

### Adiciona pontos
func _AddScore(points: int):
	MyScore += points;




func DebugMessage():
	print(MyScore);
