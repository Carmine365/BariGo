extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	# Controlliamo se chi ci ha toccato ha la funzione "raccogli_moneta" (cioè se è il giocatore)
	if body.has_method("raccogli_moneta"):
		body.raccogli_moneta() # Aggiunge la moneta al contatore
		queue_free() # Fa sparire la moneta dalla mappa
