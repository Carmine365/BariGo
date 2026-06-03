extends Area2D

func _on_body_entered(body):
	if body.name == "player1":
		var gm = get_tree().get_first_node_in_group("GameManager")
		if gm and gm.oggetti_totali >= 4:
			gm.attiva_vittoria() # Accende la scritta
			await get_tree().create_timer(2.0).timeout
			global.quest_states["piccinni"] = "completed"
			get_tree().change_scene_to_file("res://Scenes/Game.tscn")
		else:
			print("Te ne mancano ancora!")
