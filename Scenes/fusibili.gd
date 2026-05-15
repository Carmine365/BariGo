extends Area2D

func _on_body_entered(body: Node2D) -> void:
	# Controlliamo che chi ci tocca sia il nostro omino (assicurati che si chiami "player1")
	if body.name == "player1":
		
		# Controlliamo che l'omino abbia la funzione per la luce
		if body.has_method("aumenta_raggio_luce"):
			# Diamo il comando all'omino di far crescere la luce (o accenderla tutta al 3°)
			body.aumenta_raggio_luce()
		
		# Il fusibile ha fatto il suo lavoro e si elimina dalla mappa
		queue_free()
