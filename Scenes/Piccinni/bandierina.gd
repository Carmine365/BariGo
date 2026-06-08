extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player1":
		var gm = get_tree().get_first_node_in_group("GameManager")
		
		# 1. Verifica se il giocatore ha completato gli oggetti
		if gm and gm.oggetti_totali >= 4:
			gm.attiva_vittoria() # Accende la scritta
			
			# 2. Assegna l'esperienza solo ora
			GameManager.guadagna_esperienza()
			print("Vittoria e XP inviata!")
			
			# 3. Attesa prima di uscire
			await get_tree().create_timer(2.0).timeout
			
			# 4. Salvataggio e cambio scena
			global.quest_states["piccinni"] = "completed"
			get_tree().change_scene_to_file("res://Scenes/Game.tscn")
		else:
			print("Te ne mancano ancora!")
