extends Area2D

func _on_body_entered(body):
	if body.name == "player1":
		# Trova il manager guardando nella lista dei fratelli del nodo radice
		# Il ".." sale di un livello al nodo radice, poi cerca il manager lì sotto
		var manager = get_parent().get_parent().get_node("kismetmanager")
		
		if manager:
			manager.registra_lettera("2")
			call_deferred("queue_free")
		else:
			print("ERRORE: Manager non trovato! Controlla il nome del nodo.")
