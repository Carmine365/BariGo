extends Area2D

func _on_body_entered(body):
	if body.name == "player1":
		# Trova il manager (percorso fisso)
		var manager = get_parent().get_parent().get_node("kismetmanager")
		
		if manager:
			# Passiamo "4" per attivare Teatro4
			manager.registra_lettera("4") 
			call_deferred("queue_free")
		else:
			print("ERRORE: Manager non trovato!")
