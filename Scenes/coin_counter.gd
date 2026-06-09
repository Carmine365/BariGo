extends Label

func _process(_delta):
	print("DEBUG: Segnale RICEVUTO, val: ", global.coin)
	# Aggiorna il testo con il valore che sta dentro il GameManager
	text = "Monete: " + str(global.coin)
