extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Se la mia posizione esatta è già nell'array globale, significa che mi hanno già raccolta in passato.
	if global.monete_raccolte.has(global_position):
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	# Controlliamo se chi ci ha toccato ha la funzione "raccogli_moneta" (cioè se è il giocatore)
	if body.has_method("raccogli_moneta"):
		global.play_suono_moneta()
		body.raccogli_moneta() # Aggiunge la moneta al contatore
		
		# Aggiungo le coordinate di QUESTA specifica moneta alla lista dei salvataggi
		global.monete_raccolte.append(global_position)
		
		print("DEBUG: Segnale EMESSO")
		
		#global.coin = global.coin + 1
		queue_free() # Fa sparire la moneta dalla mappa
