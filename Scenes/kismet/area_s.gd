extends Area2D

func _on_body_entered(body):
	if body.name == "player1":
		# Il percorso è lo stesso di prima, perfetto!
		var manager = get_parent().get_parent().get_node("kismetmanager")
		
		if manager:
			# Qui passiamo "3" perché il tuo nodo si chiama Teatro3
			manager.registra_lettera("3") 
			call_deferred("queue_free")
		else:
			print("ERRORE: Manager non trovato!")
