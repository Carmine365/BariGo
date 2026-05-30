extends Area2D

func _on_body_entered(body):
	if body.name == "player1":
		# Invece del percorso testuale, cerchiamo il manager nella scena corrente
		# Questo metodo cerca il nodo "kismetmanager" partendo dalla radice della scena
		var manager = get_tree().root.find_child("kismetmanager", true, false)
		
		if manager:
			manager.registra_lettera("1")
			call_deferred("queue_free")
		else:
			print("ERRORE: Non trovo il nodo kismetmanager nella scena!")
