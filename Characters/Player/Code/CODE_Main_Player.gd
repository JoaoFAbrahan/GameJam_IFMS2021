extends CLASS_Character
signal _onPlayerDead(condition);

#### Player Variables
var InteractTo;
var SoundStart;

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
	if Input.is_action_pressed("PlayerAction_JUMP") && isGrounded && !isInteract:
		# Calcula a física do pulo
		VELOCITY.y = JumpHeight;
		
		# Efeito Sonoro
		$SFX/Jump_SFX.play();
		
		# StateMachine
		CharacterState = State.JUMP;

### Ação de Interação
func InteractAction(ObjRef: String):
	## Passa a referencia do tipo de objeto
	InteractTo = ObjRef;
	SoundStart = true;
	
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
				match InteractTo:
					"Tile":
						# Ativa animação de reparo de plataforma
						$AnimationPlayer.play("Interation_3 (RepararTile)");
						# Efeito Sonoro
						if SoundStart:
							$SFX/Repairing_SFX.play();
							SoundStart = false;
						
						yield($AnimationPlayer,"animation_finished");
						
						# Volta pro estado normal após a animação
						isInteract = false;
						CharacterState = State.IDLE;
					"Cano":
						# Ativa animação de desentupir cano 
						$AnimationPlayer.play("Interation_2 (Desentupir)");
						# Efeito Sonoro
						if SoundStart:
							$SFX/Cleaning_Pipe_SFX.play();
							SoundStart = false;
						
						yield($AnimationPlayer,"animation_finished");
						
						# Volta pro estado normal após a animação
						isInteract = false;
						CharacterState = State.IDLE;
					"Aliado":
						# Ativa animação de reviver aliado 
						$AnimationPlayer.play("Interation_1 (AliadoRevive)");
						
						#Efeito Sonoro
						if SoundStart:
							$SFX/Reviving_SFX.play();
							SoundStart = false;
						
						yield($AnimationPlayer,"animation_finished");
						
						# Volta pro estado normal após a animação
						isInteract = false;
						CharacterState = State.IDLE;
					"Background":
						# Ativa animação de reviver aliado 
						$AnimationPlayer.play("Interation_4 (RepararBG)");
						
						#Efeito Sonoro
						if SoundStart:
							$SFX/RepairingBackground_SFX.play();
							SoundStart = false;
						
						yield($AnimationPlayer,"animation_finished");
						
						# Volta pro estado normal após a animação
						isInteract = false;
						CharacterState = State.IDLE;
	else:
		if VELOCITY.y >= 200:
			isInteract = false;
			$AnimationPlayer.play("Fall");


#### Signals Functions
### Adiciona mais tempo
func _AddTime(time: int):
	MyTime += time;

### Remover um pouco do tempo
func _RemoveTime(time: int):
	MyTime -= time;

### Adiciona pontos
func _AddScore(points: int):
	MyScore += points;


func DebugMessage():
	#print(CharacterState);
	if Input.is_action_just_pressed("PlayerMinigame_Confirm"):
		global_position = Vector2(0,0)
