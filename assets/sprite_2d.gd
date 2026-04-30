extends CharacterBody2D

var speed = 400

func _physics_process(delta):
	# Otteniamo la direzione dagli input (frecce o WASD)
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction:
		# Se c'è un input, impostiamo la velocità
		velocity = direction * speed
	else:
		# Altrimenti, freniamo dolcemente
		velocity = velocity.move_toward(Vector2.ZERO, speed)

	# Questa funzione magica gestisce le collisioni automaticamente!
	move_and_slide()
