extends Node2D

# 1. Questa riga va qui, fuori da ogni funzione!
var nota_scena = preload("res://Scenes/Team/Nota.tscn") 

func _on_timer_timeout():
	var n = nota_scena.instantiate()
	
	# Aggiungi la nota come figlia del livello
	add_child(n)
	
	# FORZIAMO la posizione usando il Marker come riferimento ASSOLUTO
	# 'global_position' ignora la gerarchia dei nodi
	n.global_position = $PuntoSpawn.global_position
