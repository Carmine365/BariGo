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
		GameManager.guadagna_esperienza()
		global.quest_states["margherita"] = "completed"
		get_tree().change_scene_to_file("res://Scenes/Game.tscn")
		
		# 6. Cambiamo scena
		if global.next_minigame_scene != "":
			var scene_to_load: String = global.next_minigame_scene
			
			# Puliamo immediatamente il Singleton per evitare loop
			global.next_minigame_scene = ""	
			
			# Verifichiamo il percorso dinamico, NON uno statico inventato
			if ResourceLoader.exists(scene_to_load):
				get_tree().change_scene_to_file(scene_to_load)
			else:
				printerr("ERRORE DI CARICAMENTO: La scena richiesta non esiste al percorso: ", scene_to_load)
