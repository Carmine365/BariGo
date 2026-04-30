extends CharacterBody2D

const LUNGHEZZA_RAGGIO = 50.0 
const SPEED = 200.0

@onready var raggio = $RayCast2D
@onready var anim = $AnimatedSprite2D 

func _ready():
	global.player = self

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		
		# --- GESTIONE ANIMAZIONI (Nomi sincronizzati con la tua foto) ---
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				anim.play("CamminataDX")
			else:
				anim.play("CamminataSX")
		else:
			if direction.y > 0:
				anim.play("CamminataGiù")
			else:
				anim.play("CamminataSU")
		
		raggio.target_position = direction * LUNGHEZZA_RAGGIO
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
		# Il tuo omino fermo si chiama "fermo"
		anim.play("fermo")

	move_and_slide()

func raccogli_moneta():
	global.coin += 1
	print("Focaccia raccolta! Totale: ", global.coin)
