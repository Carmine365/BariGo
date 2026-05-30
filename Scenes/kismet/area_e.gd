extends Area2D

func _on_body_entered(body):
	if body.name == "player1":
		# Trova il manager
		var manager = get_parent().get_parent().get_node("kismetmanager")
		
		if manager:
			# Passiamo "5" per attivare Teatro5
			manager.registra_lettera("5") 
			call_deferred("queue_free")
		else:
			print("ERRORE: Manager non trovato!")
