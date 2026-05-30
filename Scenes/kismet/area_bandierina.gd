extends Area2D

func _on_body_entered(body):
	if body.name == "player1":
		var manager = get_tree().current_scene.find_child("kismetmanager", true, false)
		
		if manager and manager.lettere_raccolte >= 6:
			print("Vittoria! Fermo il gioco...")
			
			# 1. Stoppiamo il tempo di gioco (nessuno si muove più)
			get_tree().paused = true 
			
			# 2. Dopo un piccolo momento, cambiamo scena
			# Nota: Abbiamo bisogno di un timer "non stoppato" dal gioco
			await get_tree().create_timer(2.0, true, false, true).timeout
			
			# 3. Importante: togliamo la pausa prima di cambiare scena
			get_tree().paused = false
			get_tree().change_scene_to_file("res://Scenes/Game.tscn")
		else:
			print("Ti mancano ancora frammenti!")
