extends Area2D

# Questo crea una casella nell'Ispettore dove potrai inserire il nodo giusto!
@export var nodo_manager: Node

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player1":
		
		# Controlliamo se hai dimenticato di assegnare il nodo
		if nodo_manager == null:
			print("ERRORE: Devi assegnare il nodo manager nell'Ispettore!")
			return
			
		var monete_prese = nodo_manager.get("current_items")
		var monete_totali = nodo_manager.get("items_to_collect")
		
		if monete_prese != null and monete_totali != null:
			if monete_prese >= monete_totali:
				print("VITTORIA INNESCATA!")
				
				# Mostriamo il testo
				var label_testo = nodo_manager.get("game_over_label")
				if label_testo != null:
					label_testo.text = "Vittoria, livello completato!"
					label_testo.show()
					
				# 1. Congeliamo l'intero gioco (ferma il fuoco, l'omino, i nemici, TUTTO)
				get_tree().paused = true
				
				# 2. Aspettiamo 3 secondi per fargli godere la schermata di vittoria.
				# Il 'true' dice a Godot di far scorrere questo timer anche se il gioco è in pausa!
				await get_tree().create_timer(3.0, true).timeout
				
				# 3. SBLOCCHIAMO IL GIOCO. (Fondamentale, sennò la mappa Game.tscn nasce bloccata)
				get_tree().paused = false
				
				# 4. Carichiamo la mappa iniziale
				get_tree().change_scene_to_file("res://Scenes/Game.tscn")
				
			else:
				var mancanti = monete_totali - monete_prese
				print("Ti mancano ancora " + str(mancanti) + " monete!")
