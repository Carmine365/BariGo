extends Area2D

signal player_burned

func _ready() -> void:
	# Connetti il segnale di collisione
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	# 1. Controlliamo se il nodo è nel gruppo giusto
	if body.is_in_group("Player"):
		# 2. Controlliamo se il nodo ha lo script con la funzione die()
		if body.has_method("die"):
			body.die()
			
		player_burned.emit()
