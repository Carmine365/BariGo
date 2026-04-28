extends CharacterBody2D

const SPEED = 200.0

func _physics_process(_delta: float) -> void:
	# Input.get_vector calcola in automatico la direzione in base alle 4 frecce premute
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Se premiamo qualcosa, applica la velocità in quella direzione
	if direction:
		velocity = direction * SPEED
	# Se non premiamo nulla, fermati
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	# Applica il movimento (e gestisce gli urti contro i bordi azzurri del marciapiede)
	move_and_slide()

# Variabile per tenere il conto
var monete = 0

# Funzione che verrà chiamata dalla moneta quando la tocchiamo
func raccogli_moneta():
	monete += 1
	# Aggiorniamo il testo dell'etichetta sullo schermo
	$CanvasLayer/CoinCounter.text = "Monete: " + str(monete)
