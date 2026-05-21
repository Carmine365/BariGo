extends CharacterBody2D

const SPEED = 220.0
var JUMP_VELOCITY = -400.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if is_dead:
		return 
	
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
		
		# GESTIONE ANIMAZIONI SEPARATE
		if direction > 0:
			# Stiamo andando a destra
			_animated_sprite.play("corsa")
		else:
			# Stiamo andando a sinistra (direction < 0)
			_animated_sprite.play("corsa sx")
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
		# RIPRODUCI ANIMAZIONE FERMO (IDLE)
		_animated_sprite.play("idle")

	# 4. IL MOTORE
	move_and_slide()

# Variabile per bloccare gli input e la fisica
var is_dead: bool = false

func die() -> void:
	if is_dead:
		return 
		
	is_dead = true
	velocity = Vector2.ZERO
	set_physics_process(false)
	set_process_input(false)
	visible = false 
	$CollisionShape2D.set_deferred("disabled", true)

func _on_bandierina_vittoria_body_entered(_body: Node2D) -> void:
	pass
