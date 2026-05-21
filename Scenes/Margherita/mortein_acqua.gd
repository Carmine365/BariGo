extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_acqua_mortale_body_entered(body: Node2D) -> void:
	# Controlla se a toccare l'acqua è il player
	if body.name == "player1":
		print("Sei caduto in acqua! Ricomincio...")
		
		# Opzione 1: Ricarica istantanea
		get_tree().reload_current_scene()
		
		# Opzione 2 (Se vuoi un effetto più professionale):
		# body.die() # Se hai la funzione die() nel player, chiamala prima
		# await get_tree().create_timer(1.5).timeout
		# get_tree().reload_current_scene()eplace with function body.
