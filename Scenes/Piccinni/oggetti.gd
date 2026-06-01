extends Area2D

func _on_body_entered(body):
	if body.name == "player1":
		# Trova il manager e aggiungi 1
		var gm = get_tree().get_first_node_in_group("GameManager")
		if gm:
			gm.aggiungi_punto()
		queue_free() # L'oggetto sparisce
