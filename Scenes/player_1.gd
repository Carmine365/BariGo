extends CharacterBody2D

const VELOCITA = 200.0
var fusibili_presi = 0

# Usiamo @onready per prendere subito il riferimento all'AnimatedSprite2D
@onready var sprite = $AnimatedSprite2D 

func _physics_process(delta):
	# Otteniamo la direzione dagli input
	var direzione = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Muoviamo fisicamente l'omino
	if direzione:
		velocity = direzione * VELOCITA
	else:
		velocity.x = move_toward(velocity.x, 0, VELOCITA)
		velocity.y = move_toward(velocity.y, 0, VELOCITA)

	move_and_slide()
	
	# --- GESTIONE ANIMAZIONI ---
	if velocity.length() > 0:
		# Controlliamo quale asse è dominante (se andiamo più in orizzontale o verticale)
		if abs(velocity.x) > abs(velocity.y):
			# Movimento prevalentemente orizzontale
			if velocity.x > 0:
				sprite.play("corsaDX")
			else:
				sprite.play("corsaSX")
		else:
			# Movimento prevalentemente verticale
			if velocity.y > 0:
				sprite.play("corsa giù")
			else:
				sprite.play("corsa SU")
	else:
		# Siamo fermi, mettiamo l'animazione "idle"
		sprite.play("idle")

# --- GESTIONE LUCE E FUSIBILI ---
func aumenta_raggio_luce():
	# Prendiamo il nodo della luce (assicurati che si chiami esattamente così nell'albero!)
	var luce = $PointLight2D
	
	# Aggiungiamo 1 al contatore
	fusibili_presi += 1 
	
	# Controlliamo quanti ne abbiamo presi e allarghiamo il cerchio
	if fusibili_presi == 1:
		luce.texture_scale = 4.0 # Primo step: si allarga un po'
		print("1 Fusibile: Luce livello 1")
		
	elif fusibili_presi == 2:
		luce.texture_scale = 7.0 # Secondo step: si allarga ancora di più
		print("2 Fusibili: Luce livello 2")
		
	elif fusibili_presi >= 3:
		# Terzo step: facciamo diventare la luce gigante per coprire tutto il labirinto!
		luce
