extends Area2D

# Segnale emesso quando l'oggetto viene raccolto
signal item_collected

# Variabile per differenziare l'oggetto (utile per controlli futuri)
@export var item_name: String = "Oggetto"

func _ready() -> void:
	# Assicurati che il segnale body_entered sia connesso via codice o tramite editor
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	# Controlla che a collidere sia il giocatore tramite i Gruppi
	if body.is_in_group("Player"):
		
		# --- MODIFICA QUI ---
		# Prima di chiamare la funzione, verifichiamo che esista davvero
		if body.has_method("aumenta_raggio_luce"):
			body.aumenta_raggio_luce()
		else:
			# Se non esiste, stampiamo un avviso amichevole e non crashiamo
			print("Questo giocatore non ha la funzione aumenta_raggio_luce, salto il comando.")
		# --------------------
		
		global.play_suono_moneta()
		
		EventBus.item_collected.emit(item_name)
		item_collected.emit()
		queue_free()
