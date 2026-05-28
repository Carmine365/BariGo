extends Area2D

# Scrivi qui la lettera specifica per questo oggetto (K, I, S, M, E, T)
@export var nome_lettera: String = "K" 

func _on_body_entered(body):
	if body.name == "player1":
		# Colleghiamo al manager
		var manager = get_node("/root/livello_kismet/kismetmanager")
		manager.registra_lettera(nome_lettera)
		queue_free()
