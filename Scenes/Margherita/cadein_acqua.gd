extends Area2D

var attivo: bool = true

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass
	
func _on_body_entered(body: Node2D) -> void:
	# Se il killer è stato disattivato dalla vittoria, ignoriamo il tocco
	if not attivo:
		return
		
	if body.name == "player1":
		print("Il player è caduto in acqua!")
		var messaggio = get_node_or_null("/root/LivelloMargherita/UI/Messaggio")
		if messaggio:
			messaggio.mostra_messaggio("L'acqua del Margherita non perdona gli attori improvvisati! Riprova!")
		
		await get_tree().create_timer(3.0).timeout
		get_tree().reload_current_scene()

# Funzione di sicurezza che chiameremo per spegnere il game over
func disattiva_killer():
	attivo = false
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	print("KILLER DISATTIVATO: Il giocatore è in salvo.")
