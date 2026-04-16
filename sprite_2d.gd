extends Sprite2D

# Velocità del robot in pixel al secondo
var speed = 400 

# Questa funzione viene chiamata ogni fotogramma (frame) del gioco
func _process(delta):
	var velocity = Vector2.ZERO # Inizialmente il robot è fermo

	# Controlliamo gli input
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	# Se ci stiamo muovendo, normalizziamo la velocità (evita che sia più veloce in diagonale)
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	# Applichiamo il movimento alla posizione dello Sprite
	position += velocity * delta
