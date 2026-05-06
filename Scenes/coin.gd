extends Area2D

func _on_body_entered(body):
	# Controlliamo che sia stato proprio il Player a toccare la moneta
	# (Assicurati che il tuo omino si chiami "Player" nell'albero delle scene)
	if body.name == "Player" or body.is_in_group("player"):
		# 1. Aggiungiamo la moneta al totale globale
		global.coin += 1
		
		# 2. Facciamo sparire la moneta dalla mappa
		queue_free()
		
		# 3. Opzionale: stampa un messaggio in console per debug
		print("Focaccia raccolta! Totale: ", global.coin)
