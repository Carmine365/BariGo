extends "res://Scenes/player1.gd"

# Player Livello Margherita

# Recuperiamo il nodo delle animazioni (controlla che si chiami così nel tuo albero!)
@onready var sprite = $AnimatedSprite2D

func _ready() -> void:
	# Chiama prima la logica di inizializzazione del padre
	
	# Cambia unicamente il valore della variabile ereditata
	JUMP_VELOCITY = -500

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
		
		# --- GESTIONE ANIMAZIONI CORSA ---
		if direction > 0:
			# Stiamo andando verso destra (direction è positivo)
			sprite.play("corsa")
		elif direction < 0:
			# Stiamo andando verso sinistra (direction è negativo)
			sprite.play("corsa sx")
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		# --- GESTIONE ANIMAZIONE FERMO ---
		# Quando non premiamo nulla, l'omino si ferma. 
		# (Assicurati di avere un'animazione chiamata "idle", altrimenti mettine una che hai)
		sprite.play("idle") 

	move_and_slide()
