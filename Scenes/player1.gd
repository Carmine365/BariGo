extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

# Usiamo una variabile onready per accedere velocemente al nodo delle animazioni
@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# 1. GRAVITÀ
	if not is_on_floor():
		velocity.y += gravity * delta

	# 2. SALTO
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 3. MOVIMENTO E ANIMAZIONE
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction != 0:
		velocity.x = direction * SPEED
		
		# GESTIONE ORIENTAMENTO:
		# Se direction è -1 (sinistra), flip_h diventa true. 
		# Se direction è 1 (destra), flip_h diventa false.
		_animated_sprite.flip_h = (direction < 0)
		
		# RIPRODUCI ANIMAZIONE CORSA
		_animated_sprite.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		# RIPRODUCI ANIMAZIONE FERMO (IDLE)
		_animated_sprite.play("idle")

	# 4. IL MOTORE
	move_and_slide()
