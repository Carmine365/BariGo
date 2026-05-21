extends Area2D

@export var label_messaggio: Label 
@export var riferimento_acqua: Area2D 

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player1":
		
		# 1. STOP DIRETTO ALL'ACQUA E AL SUO KILLER FIGLIO
		if riferimento_acqua and riferimento_acqua.has_method("stop_acqua"):
			riferimento_acqua.stop_acqua()
		
		# 2. Blocchiamo il player per non farlo cadere o muovere
		body.set_physics_process(false)
		body.set_process(false)
		
		# 3. Mostriamo il messaggio usando la sua funzione
		if label_messaggio:
			label_messaggio.mostra_messaggio("Trionfo tra le onde: il teatro è salvo!")
		
		# 4. Forza il disegno a schermo del testo
		await get_tree().process_frame
		
		print("HAI VINTO! Aspetta 3 secondi...")
		
		# 5. Aspettiamo i 3 secondi di gloria
		await get_tree().create_timer(3.0).timeout
		
		# 6. Cambiamo scena
		var percorso_scena = "res://Scenes/Game.tscn"
		if ResourceLoader.exists(percorso_scena):
			get_tree().change_scene_to_file(percorso_scena)
		else:
			push_error("ERRORE: Scena non trovata in: " + percorso_scena)
