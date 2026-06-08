extends Label

func _process(_delta):
	# Aggiorna il testo con il valore che sta dentro il GameManager
	text = "Monete: " + str(GameManager.monete)
