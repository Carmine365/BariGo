extends Area2D

func _on_body_entered(body):
	if body.name == "player1":
		# Trova il manager
		var manager = get_parent().get_parent().get_node("kismetmanager")
		
		if manager:
			# Passiamo "6" per attivare Teatro6
			manager.registra_lettera("6") 
			call_deferred("queue_free")
		else:
			print("ERRORE: Manager non trovato!")
