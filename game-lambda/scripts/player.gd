extends CharacterBody2D

# Variável nova referenciando o nó do AnimatedSprite2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D # Caminho do nó

const SPEED = 80.0
const JUMP_VELOCITY = -300.0

func _physics_process(delta: float) -> void:
	# Se não está no chão, vai cair
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Lógica do pulo
	if Input.is_action_just_pressed("jump") and is_on_floor(): # jump está no mapa de entrada com outras teclas
		velocity.y = JUMP_VELOCITY

	# Lógica da direção
	var direction := Input.get_axis("left", "right") # left e right estão no mapa de entrada com outras teclas
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Lógica das animações
	if direction > 0: # SE direção maior que 0 (Direita)
		anim.flip_h = false # Não vira a imagaem
		anim.play("walk")
	elif direction < 0: # SE direção menor que 0 (Esquerda)
		anim.flip_h = true # Vira a imagem
		anim.play("walk")
	else:
		anim.play("idle") # Idle para quando estiver parado
	if not is_on_floor():
		anim.play("jump") # Jump quando não estiver no chão
	# FIZ DIFERENTE DO TUTORIAL DO VIDEO PQ ELE NAO MUDAVA DE DIREÇÃO NO PULO

	move_and_slide()
