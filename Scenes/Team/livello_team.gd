extends Node2D

# Carica la scena della nota
var nota_scena = preload("res://Scenes/Team/Nota.tscn") 

# Contatore per sapere quante note sono apparse
var contatore_note: int = 0 

func _ready() -> void:
	# 1. All'avvio, mettiamo in muto gli strumenti
	$AudioBatteria.volume_db = -80.0
	$AudioChitarra.volume_db = -80.0
	$AudioTutto.volume_db = -80.0
	
	# 2. Facciamo partire le tracce tutte insieme, in modo invisibile
	$AudioBatteria.play()
	$AudioChitarra.play()
	$AudioTutto.play()

func _on_timer_timeout() -> void:
	var n = nota_scena.instantiate()
	
	# Aggiungi la nota come figlia del livello
	add_child(n)
	
	# Posiziona la nota
	n.global_position = $PuntoSpawn.global_position
	
	# Incrementiamo il contatore ad ogni spawn
	contatore_note += 1
	
	# Controlliamo se dobbiamo attivare uno strumento
	_controlla_strumenti()


# Funzione aggiornata con i tuoi tempi esatti!
func _controlla_strumenti() -> void:
	if contatore_note == 3:
		# Alla nota numero 2 parte la Batteria
		# $SpriteBatteria.show() 
		$AudioBatteria.volume_db = 0.0
		
	elif contatore_note == 5:
		# Alla nota numero 4 si aggiunge la Chitarra
		# $SpriteChitarra.show()
		$AudioChitarra.volume_db = 0.0
		
	elif contatore_note == 7:
		# Alla nota numero 6 si aggiunge il Piano (ed esplode la traccia completa)
		# $SpritePiano.show()
		$AudioTutto.volume_db = 0.0
		$AudioBatteria.volume_db = -80.0
		$AudioChitarra.volume_db = -80.0
