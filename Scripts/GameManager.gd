extends Node

# --- Variabili di stato gioco ---
var exp_attuale: int = 0
var exp_max: int = 6
var monete: int = 0

# --- Nuova variabile per gestire l'intro ---
var intro_vista: bool = false

signal exp_aggiornata(valore_percentuale)

func guadagna_esperienza():
	# Controlla che non siamo già al massimo prima di dare altra esperienza
	if exp_attuale < exp_max:
		exp_attuale += 1
		print("Esperienza attuale: ", exp_attuale)
		
		# Calcola la percentuale
		var percentuale = (float(exp_attuale) / exp_max) * 100
		exp_aggiornata.emit(percentuale)
		
		# Se con questo punto siamo appena arrivati al massimo (6/6)
		if exp_attuale == exp_max:
			monete += 2
			print("Bonus monete! Hai trovato tutti i teatri! Totale: ", monete)
			# Abbiamo eliminato l'azzeramento dell'XP, così la barra resta al 100%!
